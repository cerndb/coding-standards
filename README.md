# coding-standards
Miscelenaeous coding standards or support files to use in IT-DB projects

## Git
For the moment you can find [[here][git/INFO.MD]] a list of git configurations
parameters and conventions expected to be followed when submiting code to
the DB On Demand related repositories.

## Java
Currently you can find here a couple of configuration files for checkstyle,
following both Sun Microsystems and Google coding practices.

An up to date version of this files can be found 
[here](https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/sun_checks.xml)

## Perl

* **pre-commit** is a pre-commit hook for repositories managing Perl code. 
It will run **Perl::Critic** and reject the files containing errors with a 
severity higher than 3. Currently it doesn't run **perl -c** for error checking
but it will probably will be implemented.

## Puppet

* **beware.pp** is a Puppet manifest which will showcase different behaviours
when evaluating variables checking for its definition status

* **pre-commit.dbod** is intended to be used as a pre-commit hook for repositories
managing puppet manifests. The dbod sufix indicates the internal call to 
puppet-lint takes the configuration parameters required to follow the DB On Demand
conventions. It will reject files containing commits breaking the parsing and
allow commits containing syntax deviations, while displaying the output of 
puppet-lint.

## Ruby

* **pre-commit** is a pre-commit hook for repositories managing Ruby code. 
It will run **ruby-lint** analyze syntax and **ruby -c** to check for code errors
(WARNING: Needs to be tested!)

