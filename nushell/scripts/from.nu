export def posix-exports []: string -> record {
  lines | each { |line|
    # First remove export prefix and replace = with : for json conversion
    let entry = $line | str replace "export " "" | str replace "=" ":"

    # If it ends with " we assume we already have key:"value" pair
    let entry = if ($entry | str ends-with '"') {
      $entry
    } else {
      # If it ends with ' let's replace ' with "
      if ($entry | str ends-with "'") {
        $entry | str replace "'" '"' | str replace -r "'$" '"'

      # If it isn't wrapped in neither " nor ' let's wrap it with "
      } else {
        ($entry | str replace ':' ':"') + '"'
      }
    }

    # Finally wrap it in braces and convert to json object with single field
    $"{($entry)}" | from json
  } | into record
}

