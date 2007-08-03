# Load the Module::Install bundled in ./inc/
use inc::Module::Install;

# Define metadata
name           'Date-Glean';
all_from       'lib/Date/Glean.pm';

requires       'DateTime';

build_requires 'Test::More';
build_requires 'Test::MockTime';

auto_install;
WriteAll;

