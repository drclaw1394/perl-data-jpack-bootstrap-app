package Data::JPack::Bootstrap::App;

our $VERSION=v0.1.0;
use 5.036000;


use Data::JPack;
use Data::JPack::App;


use File::ShareDir ":ALL";

my $share_dir=dist_dir "Data-JPack-Bootstrap-App";


sub template_path {
    my $parent_root= "$share_dir";

    #Return the root relative path and the root
    (undef, $share_dir);
    
}

# call with arrow notation
#
sub add_to_container {
  my (undef, $t)=@_;

  return unless $t isa Template::Plexsite;

  # NOTE:
  # CSS FILES REQUIRE KNOWLEDGE OF THE CURRENT WORKING DIR. 
  # This means packing in to jpack directly does not work
  # The paths in the css files would need to be modified to achieve this.
  #
  # So we only pack the js files, andd link the stylesheets like normal
  Data::JPack::App->localize_table($t, sub {
  $t->add_resource("app/lib/popper.min.js",static=>{config=>{output=>{filter=>{name=>"jpack"}}}}); 
  #$t->add_resource("app/lib/bootstrap/css/bootstrap.min.css");#,static=>{config=>{output=>{filter=>{name=>"jpack"}}}}); 
  #$t->add_resource("app/lib/bootstrap/icon/font/bootstrap-icons.min.css");#,static=>{config=>{output=>{filter=>{name=>"jpack"}}}}); 
  $t->add_resource("app/lib/bootstrap/js/bootstrap.min.js",static=>{config=>{output=>{filter=>{name=>"jpack"}}}}); 

  $t->append_slot(
    #head_start => qq|<script                   src="@{[$t->add_resource("app/lib/popper.min.js")]}"></script>|,
    head_start => qq|<link   rel="stylesheet" href="@{[$t->add_resource("app/lib/bootstrap/css/bootstrap.min.css")]}">|,
    head_start => qq|<link   rel="stylesheet" href="@{[$t->add_resource("app/lib/bootstrap/icon/font/bootstrap-icons.min.css")]}">|,
    #head_start => qq|<script                   src="@{[$t->add_resource("app/lib/bootstrap/js/bootstrap.min.js")]}"></script>|
  );

  });
  $t;
}
1;


    ###########################################################################################################################################################################################
    # \@font-face {                                                                                                                                                                           #
    #   font-family: "Bootstrap";                                                                                                                                                             #
    #   src: url("@{[$t->add_resource("app/lib/bootstrap/icon/font/fonts/bootstrap-icons.woff2")]}"), url("@{[$t->add_resource("app/lib/bootstrap/icon/font/fonts/bootstrap-icons.woff")]}"); #
    # }                                                                                                                                                                                       #
    ###########################################################################################################################################################################################
