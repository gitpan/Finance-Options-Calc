package Finance::Options::Calc;

use strict;
use Carp;
use constant PI => 4 * atan2(1,1);
use vars qw(@EXPORT @ISA $VERSION);
require Exporter;
$VERSION = 0.7;
@ISA     = qw( Exporter );

=head1 NAME

C<Finance::Options::Calc> - Calculate option value based on different models.

=head1 SYNOPSIS

    use Finance::Options::Calc;
 
    print b_s_call(80, 80, 20, 30, 4.5);
    print b_s_put (80, 80, 20, 30, 4.5);
    

=head1 DESCRIPTION

b_s_call() subroutines returns theorical value of the call option based on
Black_Scholes model. The arguments are current stock price,
strike price, time to expiration (calender days, note this module
does NOT use business days), volatility(%), annual interest rate(%) in order. 

b_s_put() subroutines returns theorical value of the put option based on
Black_Scholes model. The arguments are current stock price,
strike price, time to expiration (calender days, note this module 
does NOT use business days), volatility(%), annual interest rate(%) in order.

=head1 TODO

more calculation models will be included.

=head1 AUTHOR

Chicheng Zhang

chichengzhang@hotmail.com

=cut

@EXPORT = qw(b_s_call b_s_put);

sub b_s_call {
	
	croak "Not enough arguments.\n" unless $#_ == 4;
	my ($s, $k, $t, $vol, $r) = @_;
	$r   /= 100;
	$vol /= 100;
	$t   /= 365;	
	my $d1  = (log($s / $k) + ( $r + $vol * $vol / 2 ) * $t) / ($vol * (sqrt $t));
	my $d2  = $d1 - $vol * (sqrt $t); 
	my $c   = $s * _norm($d1) - $k * (exp (-$r*$t)) * _norm($d2);
	return sprintf "%5.5f", $c;
}

sub b_s_put {

	croak "Not enough arguments.\n" unless $#_ == 4;
	my ($s, $k, $t, $vol, $r) = @_;
	$r   /= 100;
	$vol /= 100;
	$t   /= 365;
	my $d1  = (log($s / $k) + ( $r + $vol * $vol / 2 ) * $t) / ($vol * (sqrt $t));
	my $d2  = $d1 - $vol * (sqrt $t);
	my $p   = $k * (exp (-$r*$t)) * _norm(-$d2) - $s * _norm(-$d1);
	return sprintf "%5.5f", $p;
}

sub _norm {

	my $d = shift;
        my $step= 0.01;
        my $sum= 0;
        my $x= -5 + $step / 2;
        while ( ($x < $d) && ($x < 4) )
        {
                $sum += exp(- $x * $x / 2) * $step;
                $x= $x + $step;
        }
        return $sum / sqrt(2 * PI);
}

1;

