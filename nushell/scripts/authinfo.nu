export def read [] { 
  open ~/.authinfo | lines | split column " " x machine x login x password | select machine login password
}

export def entry [machine: string] { 
  read | filter { $in.machine == $machine }
}

export def login [machine: string] { 
  entry $machine | get login | first
}

export def password [machine: string] { 
  entry $machine | get password | first
}
