# Perl Code conventions

This document describes a series of coding conventions as intended to be
followed in the different Database On Demand Perl projects.

They are mostly taken from Damian Conway's Perl Best Practices, and some
of them are enforced by the use of *perlcritic* and the provided pre-commit
hook for Git repositories.

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

**Always return via an explicit *return* **

### Returning failure

**Use a bare *return* to return failure**
