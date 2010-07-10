package Agmsc;
use Moose;
use namespace::autoclean;
our $VERSION = "0.01";
use URI;

{
    use Moose::Util::TypeConstraints;
    subtype "Agmsc::Exclusion"
        => as Ref
        => where {
            ref($_) =~ /CODE|Regexp/;
        }
    ;

}

{
    package Agmsc::Profile;
    use Moose;
    use namespace::autoclean;

    has "root" =>
        is => "ro",
        isa => "ArrayRef[URI]",
        required => 1,
        auto_deref => 1,
        ;

    has "exclude" =>
        is => "ro",
        isa => "Agmsc::Exclusion",
        ;

    has "queue_manager" =>
        is => "ro",
        required => 1,
        ;

    has "logger" =>
        is => "ro",
        ;

    has "agent" =>
        is => "rw",
        required => 1,
        ;
}


{
    package Agmsc::Link;
    use Moose;
    use namespace::autoclean;
#?    use URI;

    has "uri" =>
        is => "ro",
        isa => "URI",
        required => 1,
        ;

    has "headers" =>
        is => "ro",
        # isa => "ArrayRef[HTTP::Headers]", # keep history?
        isa => "HTTP::Headers",
        required => 1,
        ;

    has "status" =>
        is => "ro",
        isa => "Int",
       required => 1,
        ;

    has "protocol" =>
        is => "ro",
        isa => "Str",
        required => 1,
        ;

    has "links" =>
        is => "rw",
        isa => "ArrayRef[Agmsc::Link]",
        auto_deref => 1,
        ;

    has "parents" =>
        is => "rw",
        isa => "ArrayRef[Agmsc::Link]",
        auto_deref => 1,
        weak_ref => 1,
        ;

    # Role for this stuff?

    use HTTP::Date;
    use DateTime;

    sub resident {
        my $self = shift;
    }

    sub content_type {
        +shift->headers->header("Content-Type");
    }

    sub content_length {
        +shift->headers->header("Content-Length");
    }

    sub last_modified {
        my $time = str2time( +shift->headers->header("Last-Modified") );
        DateTime->from_epoch( epoch => $time );
    }

    sub expires {
        my $time = str2time( +shift->headers->header("Expires") );
        DateTime->from_epoch( epoch => $time );
    }

}



1;

__END__

Check the b-tree example.

Needs a report API so it can be plugged into something.

Needs a direct report.

Queue should schedule, in part, based on last modified times.
