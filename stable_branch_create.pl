#!/apps/android/bin/perl

use strict;
use warnings;
use YAML;
use Data::Dumper;
use Getopt::Long;

################################################################################
my $tag_number;
my $add_to_master="false";
my $master_remote_name="";
my $tag_remote_name="";
my $master_upstream="";
my $tag_upstream="";
my $master_revision="";
my $tag_revision="";
my $tag_skip_branch_push="";
my $tag_groups;
my $tag_co;
my $skip_branch_push = " ";
my %hash_path;
my %hash_branch;
my %hash_branch_master;
my %hash_branch_master_diff;
my %hash_branch_ref;
my $name;
my $path;
my $revision;
my $upstream;
my $command;
my $commit;
my $fh;
my %hash_exclude;
my %hash_project_name;
my $num;
my $project;
my $project_name;
my %hash_by_patch_name;
my $hash_config;
my $stable_branch="";
my $sha1_tags="";
my @tags="";
my $num_tags="";
my $manifest_url="";
my $dry_run;
my $push;
my $branch_groups;
my $groups;
my @br_groups="";
my $num_groups="";
###############################################################################
# Functions

###############################################################################
################################################################################
my $tool_root = "";
my $config = "";

sub usage {

   print " Usage :\n";
   print "./stable_branch_create.pl --stable_branch=<stable branch name>  --sha1_tags=<sha1 tag list, comma separated> --tool_root=<tool_root> --manifest_url=<manifest_url> \n";
   print " --stable_branch -- stable branch name \n";
   print " --sha1_tags     -- tag list separated by comma in the order of priority \n";
   print " --tool_root     -- output directory for log files \n";
   print " --manifest_url  -- manifest_url \n" ;
   print " --push          -- to push the branches, --dry_run is a default setting. \n" ;
   print " --branch_groups -- specify groups to branch off \n";
   print " \t --branch_groups=<group> to only branch group \n";
   print " \t --branch_groups=-<group> to exclude group from branching \n";
   print " Example :\n";
   print " \tBranch all projects :\n";
   print " \t./stable_branch_create.pl --stable_branch=test-mqstable --sha1_tags=QPF30.91-FOLES-SHA1,QPW30.39-LAKE-SHA1,QPK30.3-DEEN-SHA1 --tool_root=/localrepo/cnfk37/create-stable/tool_root --manifest_url=ssh://gerrit.mot.com:29418/home/repo/dev/platform/android/platform/manifest/q.git \n \n";

   print " \t Branch only 'common' group projects :\n";
   print " \t./stable_branch_create.pl --stable_branch=testing-mq-2020-q3-1 --sha1_tags=QPN30.33-NAIRO-A-SHA1 --tool_root=/localrepo/cnfk37/temp10/tool_root --manifest_url=ssh://gerrit.mot.com:29418/home/repo/dev/platform/android/platform/manifest/q.git --branch_groups=common \n \n";

   print "\t Branch all except 'common' group projects :\n";
   print "\t ./stable_branch_create.pl --stable_branch=testing-mq-2020-q3-1 --sha1_tags=QPN30.33-NAIRO-A-SHA1 --tool_root=/localrepo/cnfk37/temp10/tool_root --manifest_url=ssh://gerrit.mot.com:29418/home/repo/dev/platform/android/platform/manifest/q.git --branch_groups=-common \n \n";

}

GetOptions( "stable_branch=s" => \$stable_branch ,
            "sha1_tags=s" => \$sha1_tags ,
            "branch_groups=s" => \$branch_groups ,
            "manifest_url=s" => \$manifest_url ,
            "push" => \$push ,
            "tool_root=s" => \$tool_root );

if ($stable_branch eq "") {
  print "stable_branch is not set [$stable_branch] , existing \n";
  usage ();
  exit; }

if ($sha1_tags eq "") {
  print "sha1_tags is not set [$sha1_tags] , existing \n";
  usage ();
  exit; }
else {
  @tags = split(",",$sha1_tags);
  $num_tags = scalar (@tags);
  print "Stable line created for $num_tags , sha1_tags is @tags continue creating stable branches \n";
}

if ($branch_groups eq "") {
  print "branch_groups not set [$branch_groups] , branching everything as usual!! \n";
} else {
  @br_groups = split(",",$branch_groups);
  $num_groups = scalar (@br_groups);
  print "Stable branches to be created for groups @br_groups, continue.. \n";
}

if ($tool_root eq "") {
  print "tool_root is NOT valid in config file, using [$tool_root]\n";
  usage ();
  exit;
} else {
  print "tool_root is valid in config file, using [$tool_root]\n";
}

### dry_run by default, add --push command explicitly to push create stable branches
if ($push) {
  $dry_run="";
  print " *********************************************************************** \n ";
  print " ***********   dry_run NOT SET! Branches will be pushed     ************ \n ";
  print " *********************************************************************** \n ";
} else {
  $dry_run=1;
  print " *********************************************************************** \n ";
  print " **************              dry_run ONLY                 ************** \n ";
  print " *********************************************************************** \n ";
}


if ($manifest_url eq "") {
  print "manifest_url is needed for cloning , existing \n";
  usage ();
  exit; }
else {
  print "Cloning manifest from path $manifest_url\n";
  `cd $tool_root; rm -rf manifest; git clone $manifest_url manifest`;
}

  print "stable_branch is [$stable_branch]\n";
  print "sha1_tags is [$sha1_tags]\n";

######## functions #############

sub master_hash {
          my $tn=0;
   foreach my $tag (@tags) {
            $tn++;
     foreach my $name (keys %{$hash_path{$tag}}) {
        if (!($hash_branch_master{$name})){
             $hash_branch_master{$name}->{"path"}=$hash_path{$tag}{$name}->{"path"};
             $hash_branch_master{$name}->{"name"}=$hash_path{$tag}{$name}->{"name"};
             $hash_branch_master{$name}->{"upstream".$tn}=$hash_path{$tag}{$name}->{"upstream"} if $hash_path{$tag}{$name}->{"upstream"};
             $hash_branch_master{$name}->{"revision".$tn}=$hash_path{$tag}{$name}->{"revision"} if $hash_path{$tag}{$name}->{"upstream"};
             $hash_branch_master{$name}->{"stable-upstream".$tn}=$stable_branch."/".$hash_branch_master{$name}->{"upstream".$tn} if $hash_branch_master{$name}->{"upstream".$tn};
             $hash_branch_master{$name}->{"skip_branch_push".$tn}=$hash_path{$tag}{$name}->{"skip_branch_push"} if $hash_path{$tag}{$name}->{"skip_branch_push"};
             $hash_branch_master{$name}->{"groups".$tn}=$hash_path{$tag}{$name}->{"groups"} if $hash_path{$tag}{$name}->{"groups"};
        }else{
             $master_remote_name=$hash_branch_master{$name}->{"name"} ;
             $tag_remote_name=$hash_path{$tag}{$name}->{"name"};

             $tag_number=1;
             for (my $i=1; $i < $tn; $i++) {
                $master_revision=$hash_branch_master{$name}->{"revision".$tag_number} ;
                $master_upstream=$hash_branch_master{$name}->{"upstream".$tag_number} ;

                $tag_revision=$hash_path{$tag}->{$name}->{"revision"};
                $tag_upstream=$hash_path{$tag}->{$name}->{"upstream"};
                $tag_skip_branch_push=$hash_path{$tag}->{$name}->{"skip_branch_push"} ;
                $tag_groups=$hash_path{$tag}->{$name}->{"groups"} ;

                if ($master_remote_name eq $tag_remote_name) {
                      $tag_number++;
                  if ($master_upstream) {
                    if ($tag_upstream ne $master_upstream) {
                      #print "Debugging $tag_upstream not same as $master_upstream for $name \n" ;
                      $add_to_master="true";
                     }else {
                      $add_to_master="false";
                     }
                  } else { if ($tag_upstream) {$add_to_master="true";}}
                }
                  last if ($add_to_master eq "false");
             }
             if ($add_to_master eq "true") {
                #print "Debugging add to master_hash $add_to_master $name $tag_number $tag_upstream $tag_revision\n";
                $hash_branch_master{$name}->{"upstream".$tag_number}=$tag_upstream if $tag_upstream;
                $hash_branch_master{$name}->{"revision".$tag_number}=$tag_revision if $tag_upstream;
                $hash_branch_master{$name}->{"stable-upstream".$tag_number}=$stable_branch."/".$tag_upstream if $tag_upstream;
                $hash_branch_master{$name}->{"skip_branch_push".$tag_number}=$tag_skip_branch_push if $tag_skip_branch_push;
                $hash_branch_master{$name}->{"groups".$tag_number}=$tag_groups if $tag_groups;
             }
        }
     }
   }
    #  print Dumper(\%hash_branch_master);
}

sub check_exclude {

my @exclude_list= (
"home/repo/dev/platform/android/motorola/tools/inttool",
"home/repo/dev/platform/android/motorola/security/hab_cst_client",
"home/repo/dev/platform/android/motorola/bootable/bootloader/mot_fastboot",
"home/repo/dev/platform/android/motorola/bootable/bootloader/boottools",
"home/repo/dev/platform/android/motorola/modem/simlock",
"home/repo/dev/platform/android/motorola/packages/apps/PerfMonitor",
"motorola/AndroidNDK",
"motorola/AndroidSDK",
"home/repo/dev/apps/IQDataUploadReport"
);

foreach $project (@exclude_list) {
       # print "exclude $project \n";
        $hash_exclude{$project} = 1;
      }
#print Dumper(\%hash_exclude);

foreach $project (keys %hash_branch_master) {
     if (exists $hash_exclude{$project}) {
       $hash_branch_master{$project}{"exclude"}=1;
       #print "Debugging exclude project $hash_branch_master{$project}{exclude} \n";
     }
   }
}



sub push_branch {
  my $push_cmd;
  my $tag_number;
  my $upstream;
  my $revision;
  my $stableBranch;
  my $skipBranch;
  my $skipProject;
  my $command;
  my $rowCount;
  my $groups;
  my $path;

  foreach my $name (keys %hash_branch_master) {
    $skipProject=$hash_branch_master{$name}->{"exclude"};
    if (!$skipProject) {
      for ($tag_number=1; $tag_number <= $num_tags; $tag_number++) {
        $path=$hash_branch_master{$name}->{"path"};
        $upstream=$hash_branch_master{$name}->{"upstream".$tag_number};
        $revision=$hash_branch_master{$name}->{"revision".$tag_number};
        $stableBranch=$hash_branch_master{$name}->{"stable-upstream".$tag_number};
        $skipBranch=$hash_branch_master{$name}->{"skip_branch_push".$tag_number};
        $groups=$hash_branch_master{$name}->{"groups".$tag_number};

        open my $fh_branch_exists,  '>>', "$tool_root/output_branches_exists.txt"  or die "Can't open left_commits.txt: $!";
        open my $fh_branch_skipped,  '>>', "$tool_root/output_branches_skipped.txt"  or die "Can't open left_commits.txt: $!";
        open my $fh_branch_created,  '>>', "$tool_root/output_branches_created.txt"  or die "Can't open left_commits.txt: $!";

         ## for printing groups list
         ##print $fh_branch_exists "$path,$revision,$upstream,$groups \n" ;

         if ($skipBranch) {
           print $fh_branch_skipped "SKIPPING $name $skipBranch $groups \n";
         } else {
            if (($upstream) && ($revision) && ($stableBranch) && (!$skipBranch) ) {

            #if ( $path eq "motorola/build_ids" ) {
            #  print "path=$path tag_number=$tag_number upstream=$upstream $name ${stableBranch} $revision \n";
            #}

           # there is no actual dry_run for create_branch, dry_run only shows branches/revision for a project
           # if not dry_run , attempt to create-branch
           # create-branch throws error if branch exists
           # $push_cmd="ssh -p 29418 gerrit.mot.com gerrit create-branch home/repo/dev/platform/android/motorola/build_ids testing f0612468a208880e4a9032ca0ec59d01b733b4da";

              $push_cmd="ssh -p 29418 gerrit.mot.com gerrit create-branch $name $stableBranch $revision";
              if ($dry_run) {
                print "\ndry_run Creating branch \nCommand:$push_cmd \nStablebranch:$stableBranch \nproject:$name \nrevision:$revision \ngroups:$groups\n";
                print $fh_branch_created "\ndry_run Creating branch \nCommand:$push_cmd \nStablebranch:$stableBranch \nproject:$name \nrevision:$revision \ngroups=$groups\n" ;
              } else {
                print "\nCreating branch\n";
                print "Command:$push_cmd \nStablebranch:$stableBranch \nproject:$name \nrevision:$revision\n \ngroups=$groups\n";
                my $out_log=`$push_cmd 2>&1`;
                if ($out_log) {
                   print "$out_log \n";
                   print $fh_branch_exists "\nRunning branch create \nCommand:$push_cmd \nStablebranch:$stableBranch \nproject:$name \nrevision:$revision \ngroups:$groups \n$out_log \n" ;
                } else {
                   print "Branch created \n";
                   print $fh_branch_created "\nRunning branch create \nCommand:$push_cmd \nStablebranch:$stableBranch \nproject:$name \nrevision:$revision \ngroups:$groups Success\n" ;
                }
              } #!dry_run
            }
         } #!skipBranch
      }
    } else {
      print "excluding $name from branching \n" ;
    }
  } 
  #print Dumper(\%hash_branch_master);
} # sub_push
################################################################################

my $tag;
foreach $tag (@tags) {

        $name="";
        $path="";
        $revision="";
        $upstream="";
        $skip_branch_push="";

        my $manifest_path="$tool_root/manifest";
        my $manifest_file="sha1_embedded_manifest.xml";
        $command=`cd $manifest_path;git checkout $tag`;
        $tag_co=$command;

 open (FILE, "$manifest_path/$manifest_file") or die "Can't open $manifest_path/$manifest_file: $!";
   while (<FILE>) {
        $name="";
        $path="";
        $revision="";
        $upstream="";
        $skip_branch_push="";
        my @pairs="";
        chomp;
        if ($_ =~ /^\s+<project/){
          @pairs = split(" ");
          my $p;
          foreach $p (@pairs)
          {
              if ($p =~ /^path="(.*)"/) {
                 $path=$1; }
              if ($p =~ /^name="(.*)"/) {
                 $name=$1; }
              if ($p =~ /^revision="(.*)"/) {
                 $revision=$1; }
              if ($p =~ /^upstream="(.*)"/) {
                 $upstream=$1; }
              if ($p =~ /^groups="(.*)"/) {
                 $groups=$1; }
          }
          if (!$name) {
            print "project path and name are same \n";
            $name=$path;
          }

          if ($upstream =~ /^refs\/tags(.*)/) {
            #print "upstream refs to a tag for $path,do not push branch \n";
            $skip_branch_push=1;
          } elsif ($upstream =~ /q-fs-release/) {
            #print "upstream refs to a tag for $path,do not push branch \n";
            $skip_branch_push=1;
          } elsif ($upstream) {
              # build_ids is branched both for quaterly and stable lines.
              # for stable lines branch name should exclude quaterly branch prefix,
              # as they are independent
              if ($path eq "motorola/build_ids") {
                 if ($upstream =~ /(.*)\/(.*)/) {
                    print " motorola/build_ids upstream set to $upstream. Set it to $2 \n";
					#如果分支是：a/b形式的，则把分支改成b
                    $upstream=$2;
                    $skip_branch_push="";
                 }
              } else {
              if ($num_groups) {
                my $m;
                foreach $m (@br_groups) {
                ## if branch_groups starts with - , exclude the group from branching
                if ($m =~ /^-/) {
                  my $n = $m;
                  $n =~ s/-//;
				  #$n==common
                  if ($groups =~ $n) {
                     print "Do not Branch $path group set to $groups \n";
                     $skip_branch_push=1;
                     last;
                  } else {
                     #print "Branch $path group set to $groups \n";
                     $skip_branch_push="";
                  }
                } else {
                ## branch only projects with groups in --branch_groups
                  if ($groups =~ $m) {
                     #print "$groups has $m \n";
                     $skip_branch_push="";
                     last;
                  } else {
                     #print "$groups doesn't have $m , skip \n";
                     $skip_branch_push=1;
                  }
                }

                }
              }
              }
            ## for debug
            ##print "skip_branch_push is set to $skip_branch_push for upstream $path, $name $revision \n";
          } elsif (!$upstream) {
              #print "upstream doesn't exist for $path, $name $revision do not push branch \n";
              $skip_branch_push=1;
          }
#### Prepare hash for each sha1 tag - find path , remote , revision, upstream
          if ($path) {
            $hash_branch{$tag}->{"path"}=$path;
            $hash_path{$tag}->{$name}->{"path"}=$path;
          }
          if ($name){
            $hash_branch{$tag}->{"name"}=$name;
            $hash_path{$tag}->{$name}->{"name"}=$name;
          }
          if ($revision){
            $hash_branch{$tag}->{"revision"}=$revision;
            $hash_path{$tag}->{$name}->{"revision"}=$revision;
          }
          if ($upstream){
            $hash_branch{$tag}->{"upstream"}=$upstream;
            $hash_path{$tag}->{$name}->{"upstream"}=$upstream;
          }
          if ($skip_branch_push){
            $hash_branch{$tag}->{"skip_branch_push"}=$skip_branch_push;
            $hash_path{$tag}->{$name}->{"skip_branch_push"}=$skip_branch_push;
          }
          if ($groups){
            $hash_branch{$tag}->{"groups"}=$groups;
            $hash_path{$tag}->{$name}->{"groups"}=$groups;
          }
          

          $name="";
          $path="";
          $revision="";
          $upstream="";
          $skip_branch_push="";
    }
  }
   close FILE;
#print Dumper(\%hash_path); 
#print Dumper(keys %hash_path); 
#print Dumper (keys %{$hash_path{$tag}});
}


## build master hash
 master_hash ();
## check for exclude project list
 check_exclude (); 
## push the branch
 push_branch ();
exit;
