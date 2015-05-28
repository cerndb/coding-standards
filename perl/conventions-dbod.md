# Perl Code conventions

This document describes a series of coding conventions as intended to be
followed in the different Database On Demand Perl projects.

They are mostly taken from Damian Conway's Perl Best Practices, and some
of them are enforced by the use of *perlcritic* and the provided pre-commit
hook for Git repositories.

## Code layout

### Indentation

**Use four-column indentation levels**

### Tabs

**Indent with spaces, not tabs**

### Breaking long lines

Try to avoid excesively long lines by breaking them:

```perl
$ssh = Net::OpenSSH->new("$user\@$host", password => $arg_ref->{password}, master_stdout_discard => 0, master_stderr_discard => 1);

$ssh = Net::OpenSSH->new("$user\@$host",
        password => $arg_ref->{password},
        master_stdout_discard => 0,
        master_stderr_discard => 1);
```
## Naming conventions

### Booleans

**Name booleans after their associated test**

Suggestion, use the prefix *is_* or *has_*:

```perl
sub is_valid;
sub metadata_available_for;
sub has_end_tag;

my $loading_finished;
my $has_found_bad_record;
```

### Reference variables

**Mark variables that store references with a *_ref* suffix**

### Arrays and hashes

**Name arrays in the plural and hashes in the singular**

```perl
my %option;
my $option_ref = \%option;
my @events;
my @handlers
```

### Underscores

**Use undersocres to separate words in multiwords identifiers**

### Utility Subroutines

**Prefix "for internal use only" subroutines with an underscore**

## Subroutines

### Named arguments

**Use a hash of named arguments for any subroutine that has more than three 
parameters**

```perl
sub padded {
    my ($arg_ref) = @_;

    my $gap   = $arg_ref->{cols} - length $arg_ref->{text};
    my $left  = $arg_ref->{centered} ? int($gap/2) : 0;

    # Rest of subroutine

}

# call example
$line = padded({
    text => $line, 
    cols => 20..21,
    centered => 1,
    filler => $SPACE
    });
```

### Scalar return values

**Always *return scalar* in scalar returns**

### Implicit returns

**Always return via an explicit _return_**

### Returning failure

**Use a bare *return* to return failure**
