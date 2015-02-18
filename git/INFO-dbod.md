# DBOD Service configuration module 

## Git configuration
Before working on the repository, please be sure you have read [1]
http://configdocs.web.cern.ch/configdocs/overview/git.html

### Fancy git log output:
This alias provides a better commit log history:

    $ git config --global alias lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

### Push/pull configuration

    $ git config --global branch.autosetuprebase always
    $ git config --global pull.default simple
    $ git config --global push.default simple

## Commiting and commit messages
A commit should include changes relating to a single functionality
or item, in an atomic way, in case said changes need to be reverted.

Commit messages are intended to be helpful in understanding the evolution of 
the code. Be verbose. 

When the commit affect only a sub-class or component, it's helpful
to prefix the commit message with the name of the module, like in:

    * 4f1135c - Added /etc/dbod folder + certificate files (5 months ago) <icoteril>
    * f0f17ff - MySQL: Fixed deprecated innodb_read_io_thread to innodb-read-io-threads (5 months ago) <icoteril>
    * 1c60630 - MySQL: Added SSL configuration to mysql_cnf template (5 months ago) <icoteril>
    * 78c7aa9 - MySQL: Fixed path of Exec['install_db'] for NFS mounts tests (5 months ago) <icoteril>

## Squashing commits
When testing it's common to have a few commits with incremental changes and 
quick, non-relevant commit messages. Once things are working these commits
should be squashed into a single commit, to avoid poluting the commit history.

Examnple:

    | * | 5f12a7f - Creating dsm.opt configuration files (6 days ago) <ruben>
    | * | 0be984b - Creating dsm.opt configuration files (6 days ago) <ruben>
    | * | c0ee606 - Creating dsm.opt configuration files (6 days ago) <ruben>
    | * | 9f4c998 - Creating dsm.opt configuration files (6 days ago) <ruben>
    | * | cf65fa8 - Creating dsm.opt configuration files (6 days ago) <ruben>
    | * | e96bc77 - Template to be used by a type (6 days ago) <ruben>

Before merging this branch, it would have been possible to execute

    $ git rebase -i e96bc77

And group commits and even reword the commit messages

## Branches
In the repository there are and will be several branches:

Three main permanent branches:
* **master** : As applied in PROD servers. 
    Corresponds with the db_qX_20XX_prod environments
* **beta** : As applied in servers hosting TEST instances. 
    Corresponds with the db_qX_20XX_beta  environments
* **qa**: Intended for QA and Puppet integration test machines

You will find a varying number of other branches at a certain moment in
time. This are what are called topic or feature branches for development
of new features.

The development procedure should be like this. For the development of a new
feature, let's say feature A:

1. Branch from **qa**, creating branch **feature_A**, and develop you functionality
    there.
2. Once the functionality is ready, cleanse your branch commit history and merge
    into **qa**.
3. If there are no issues on the QA machines, merge **qa** into **beta**
4. After 48 hours have passed without problems on any **beta** machine,
    merge into **master**

### Merging branches
In order to avoid unuseful messages on the log commit like :
    
    * |   56f1c1e - Merge branch 'qa' (10 days ago) <icoteril>

please set up the following configuration parameters if you have not done it:

    $ git config --global branch.autosetuprebase always
    (path-to-your-repo) $ git config branch.master.rebase true

The objective is to avoid having the history looking like this when merging:

    | * |   2c0eb7a - FIX: Broken broken comparison to undef (3 weeks ago) <icoteril>
    | |\ \  
    | * \ \   56f1c1e - Merge branch 'qa' (3 weeks ago) <icoteril>
    | |\ \ \  
    | * \ \ \   60ad253 - Merge branch 'qa' (3 weeks ago) <Daniel Cano>
    | |\ \ \ \  
    | * \ \ \ \   8c1f422 - Merge branch 'qa' (3 weeks ago) <Daniel Cano>
    | |\ \ \ \ \  
    | * \ \ \ \ \   02929b0 - Merge branch 'qa' (3 weeks ago) <Daniel Cano>
    | |\ \ \ \ \ \  

If the changes don't overlap when mergin, this merge commits won't be created.
This can't be avoided in all cases, as with complex commits they will appear.
In this case use a meaningful commit message explaining the reason of the merge
(e.g: which functionality is being merged)

## Git-hooks
You can find a pre-commit hook in https://github.com/CERNdb/coding-standards/
(file **puppet/pre-commit.dbod**) which will check both the syntax and correctness
of your puppet manifest and templates before performing a commit.

You can just copy it to /path/to/your/repo/.git/hooks removing the .dbod sufix, 
and it will be called before performing a commit.

You also can find additional information in [1] about how to set this globally
in your Git configuration. I.e:

To add a set of standard githooks to validate your syntax on the local commit:

    $ mkdir ~/.git_template
    $ git clone https://github.com/drwahl/puppet-git-hooks.git ~/.git_template/hooks
    $ git config --global init.templatedir '~/.git_template'

then re-clone all your Puppet Git repos.

## Puppet Style Guide
The full guide can be found in [3].
If the git-hook mentioned previously is set-up, it will use puppet-lint to check
the code adherence to the style guide (as should be done!) with a few opinionated
differences.


## Links

[1] http://configdocs.web.cern.ch/configdocs/overview/git.html
[2] http://kernowsoul.com/blog/2012/06/20/4-ways-to-avoid-merge-commits-in-git/
[3] https://docs.puppetlabs.com/guides/style_guide.html
