# Load the Module::Install bundled in ./inc/
use inc::Module::Install;

# Define metadata
name           'Date-Extract';
all_from       'lib/Date/Extract.pm';

requires       'List::Util';
requires       'Carp';

# this actually requires DTFN + a patch for timezone handling
requires       'DateTime::Format::Natural' => '0.58';

requires       'parent';
requires       'Class::Data::Inheritable';

build_requires 'Test::More';
build_requires 'Test::MockTime';

auto_install;
WriteAll;

