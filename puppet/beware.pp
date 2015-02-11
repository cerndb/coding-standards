#
# Run with:
#   $ puppet apply beware.pp
#
# I found this class in some blog post about inconsistences in puppet
# comparisons.
#
# Apparently the behaviour is not only funny but also changing with versions,
# as the original author comments doesn't exactly match the results with the
# puppet version I'm using at least. The original comments remain unchanged to 
# also showcase this
#

class magic {

  $h = { a => 42}

  if $h['a']            { notice( 'if A should print' ) }
  if defined( $h['a'] ) { notice( 'defined A should print' ) }
    # doesn't print, but should
  if has_key( $h, 'a' ) { notice( 'has_key A should print' ) }

  if $h['b']            { notice( 'if B should not print' ) }
    # prints but shouldn't
  if defined( $h['b'] ) { notice( 'defined B should not print' ) }
  if has_key( $h, 'b' ) { notice( 'has_key B should not print' ) }
  if $u                 { notice( 'if U should not print' ) }
  if defined( $u )      { notice( 'defined U should not print' ) }
    # runtime error, but shouldn't
  else { notice( 'defined U should print else' ) }  # doesn't print, but should

  notice( 'No execution errors' )  # doesn't reach here, but should
}

include magic

