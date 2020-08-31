package Person;
sub new{
	my $class=shift;
	my $self={
		_firstName=>shift,
		_lastName=>shift,
		_ssn=>shift,
	};
	print "name:$self->{_firstName}\n";
	print "姓名：$self->{_lastName}\n";
	print "Id:$self->{_ssn}\n";
	bless $self,$class;
	return $self;
}

sub setFirstName{
	my($self,$firstName)=@_;
	$self->{_firstName}=$firstName if defined($firstName);
	return $self->{_firstName};
}

sub getFirstName{
	my($self)=@_;
	return $self->{_firstName};
}
1;

