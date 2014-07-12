use strict;

my $exitWords = "bye|goodbye|quit";
my $days = "Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday";
my $times = "Evening|Morning|Afternoon";

# popular stations from http://www.greateranglia.co.uk/travel-information/journey-planning/timetables
my $trainStations = "London|Braintree|Colchester|Ely|Stratford|Broxbourne|Cheshunt|Enfield Town|Clacton-on-Sea|Shenfield|Chingford|Peterborough|Marks Tey|Upminster|Sheringham|Harwich|Manningtree|Norwich|Great Yarmouth|Lowestoft|Cromer|Sudbury|Southend Victoria|Romford|Cambridge|Ipswich";

#should read from file :/
my @rules = (
    ["I want to go to ($trainStations).*this ($times).*"   , '"Greater Anglia apologises for the delay of this $2’s services to $1. This is due to the weather."'],
    ["I want to go to (.+).*this ($times).*"               , '"Sorry I have no idea where $1 is."'],
    [".*go to ($trainStations).*($days) ($times).*"        , '"There will be bus replacement services on $2 $3 to $1. Greater Anglia apologises ..."'],
    [".*go to ($trainStations).*this ($times).*"           , '"Greater Anglia apologises for the delay of this $2’s services to $1. This is due to the weather."'],
    [".*go to ($trainStations).*"                          , '"Greater Anglia apologises for the delay of services to $1. This is due to the weather."'],
    [".*go to (.+).*"                                      , '"Sorry I have no idea where $1 is."'],
    [".*this.*($times).*"                                  , '"There are no direct trains running this $1."'],
    [".*($days).*($times).*"                               , '"There is no direct train $1. This is due to an earlier incident."'],
    [".*($days).*"                                         ,  '"There will be bus replacement services on $1. Greater Anglia apologises ..."'],
    [".*(Hard|Long|Big|Large|Rough).*"                     , '"Thats what she said !"'],
    [".*Tim.*"                                             , '"TIM is a bit of a dick !, don\'t listen to him."']
);

print "User: ";

while(<stdin>) {
    my $input = $_;

    if ($input =~ /($exitWords)/i) {
        print "Eliza: Goodbye\n";
        exit 1;
    }

    # perform first match
    my $match = 0;
    for (my $i = 0; $i <= $#rules; $i++) {
        if( $match == 0 && $input =~ s/$rules[$i][0]/$rules[$i][1]/geei ){
            print "Eliza: $input";
            $match = 1;
        }
    }

    # default response
    if ($match == 0) {
        print "Eliza: WTF are you talking about ?\n";
    }
    
    print "User: ";
}