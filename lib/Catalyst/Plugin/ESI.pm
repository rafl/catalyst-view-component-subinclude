package Catalyst::Plugin::ESI;
use warnings;
use strict;

=head2 setup_esi

Sets up ESI includes by adding a "esi_include" coderef to the stash which will
either issue a subrequest or emit ESI include markups. The desired behavior can
be chosen through the config file, e.g.: 

  <Plugin::ESI>
    include_behavior subrequests
  </Plugin::ESI>

Accepted values are: C<subrequests> and C<esi>.

=cut

sub setup_esi {
    my ($c) = @_;
    
    my $include_callback;

    my $mode = $c->config->{'Plugin::ESI'}->{include_behavior} || 'subrequests';
    if ($mode =~ /^subrequest/) {
        $include_callback = sub {
            my ($path, $params) = @_;
            my $stash = {};
            $c->sub_request( $path, $stash, $params );
        };
    }
    elsif ($mode eq 'esi') {
        $include_callback = sub {
            my $url = $c->uri_for( @_ );
            '<!--esi <esi:include src="' . $url->path . '" /> -->';
        };
    }
    else {
        $c->log->error("Invalid Plugin::ESI include behavior: $mode");
        return;
    }

    $c->stash->{esi_include} = $include_callback;
}

1;