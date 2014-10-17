node 'rundeckSlave' {

  $rundeckGroup = 'wheel'

  user { 'rundeck':
    ensure  => 'present',
    groups   => $rundeckGroup,
    shell   => '/bin/bash',
    managehome  => true,
    home        => '/home/rundeck',
  }

  file { '/home/rundeck':
    ensure   => directory,
    require  => User['rundeck'],
    owner    => 'rundeck',
    group   => $rundeckGroup,
  }

  file { '/home/rundeck/.ssh':
    ensure   => directory,
    require  => File['/home/rundeck'],
    owner    => 'rundeck',
    group   => $rundeckGroup,
  }

  file { '/home/rundeck/.ssh/authorized_keys':
    content  => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA7ylERRPBlISlvq+bDyFzGMCE4h5PkfjGkF05Vmb6qbYhePw9Rp79BtWmfss6bUMtKe8PgjH0xnuDnZjtbog6043ZAOKWdy4lu2BRfXCxY7Xx61B+NirWHcA7qFHaoa68G1IazNQ9Nj3qQwTn6QdmHwNL/CrB9oGnEIqaozkGo+EFtoZht3Ig974ib0DPXnJdvsAo4euPj8PJsQdMk8rJ1EgkBBZPfDSClAgzqLfUOY2TOv4wYZ4NYiR1QLEQmJminYmiBhh2/OQrbYdGkJ4Q3c3AjsQH46bEyd7BXBBJTfIo8S0SgUdgRM6JDP5/zcZbafmjNOR+Cb3IDFyeVUc20w== rundeck@rundeckMaster',    require  => File['/home/rundeck/.ssh'],
    owner    => 'rundeck',
    group    => $rundeckGroup,
  } 

}
