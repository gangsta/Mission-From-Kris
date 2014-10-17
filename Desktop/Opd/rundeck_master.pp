node 'rundeckMaster' {

  $java = 'java-1.6.0-openjdk'

  yumrepo { 'rundeck':
    descr     => 'rundeck-release-bintray',
    baseurl   => 'http://dl.bintray.com/rundeck/rundeck-rpm',
    gpgcheck  => 0,
    enabled   => 1,
  }

  package { 'rundeck':
    ensure  => 'present',
    require => Yumrepo['rundeck'],
    before  => Package["${java}"],
  }

  package { $java:
    ensure  => 'present',
  }

  # Firewall rule for dashing
  firewall { '010 explicit rule dashing':
    proto   => 'tcp',
    dport   => '4440',
    action  => 'accept',
  }

  service { 'rundeckd':
    ensure  => 'running',
    require => Package['rundeck', "${java}"],
  }

  user { 'rundeck':
    ensure  => 'present',
    require => Service['rundeckd'],
    shell   => '/bin/bash',
  }

  file { '/var/lib/rundeck':
    ensure  => directory,
  }

  file { '/var/lib/rundeck/.ssh/id_rsa.pub':
    ensure   => file,
    owner    => 'rundeck',
    group    => 'rundeck',
    mode     => '0600',
    content  => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA7ylERRPBlISlvq+bDyFzGMCE4h5PkfjGkF05Vmb6qbYhePw9Rp79BtWmfss6bUMtKe8PgjH0xnuDnZjtbog6043ZAOKWdy4lu2BRfXCxY7Xx61B+NirWHcA7qFHaoa68G1IazNQ9Nj3qQwTn6QdmHwNL/CrB9oGnEIqaozkGo+EFtoZht3Ig974ib0DPXnJdvsAo4euPj8PJsQdMk8rJ1EgkBBZPfDSClAgzqLfUOY2TOv4wYZ4NYiR1QLEQmJminYmiBhh2/OQrbYdGkJ4Q3c3AjsQH46bEyd7BXBBJTfIo8S0SgUdgRM6JDP5/zcZbafmjNOR+Cb3IDFyeVUc20w== rundeck@rundeckMaster',
  }

  file { '/var/lib/rundeck/.ssh/known_hosts':
    ensure   => file,
    owner    => 'rundeck',
    group    => 'rundeck',
    content  => '192.168.1.101 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAswAyqQov4UF4luM2sjgPygx4sWif2pL/7g3oRUcJHsSLPzhy+omFnQisJjGH1FfwOwCg0t08uTcag1lTEKQnrZzk5XnmG4dC+paGhC03n7DE1lYNeQNivWiQpeW3zkBBFGiw5MfHVMnjMTHF14z1C/vsEN0Nzz7QI4C53MbCyBEcT3x5Ttnb/+cx2j17/UlGXRF7yxT7nEQmjhkI4Ix9GJTQE2Oxn0HazKbY7BsKs71m/EyXp4mmgY/qtZ4UIBWCSrN33mJ22I3Wgi9skJffFVNJgXZUDITq2csxOkcQ+Jue/FSfsRWwclTB9FG7bBnLR1gHWbIHRfkfGy3V8XZkXw==',
  }

  file { '/var/lib/rundeck/.ssh/id_rsa':
    ensure    => file,
    owner     => 'rundeck',
    group     => 'rundeck',
    mode      => '0600',
    content   => '-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA7ylERRPBlISlvq+bDyFzGMCE4h5PkfjGkF05Vmb6qbYhePw9
Rp79BtWmfss6bUMtKe8PgjH0xnuDnZjtbog6043ZAOKWdy4lu2BRfXCxY7Xx61B+
NirWHcA7qFHaoa68G1IazNQ9Nj3qQwTn6QdmHwNL/CrB9oGnEIqaozkGo+EFtoZh
t3Ig974ib0DPXnJdvsAo4euPj8PJsQdMk8rJ1EgkBBZPfDSClAgzqLfUOY2TOv4w
YZ4NYiR1QLEQmJminYmiBhh2/OQrbYdGkJ4Q3c3AjsQH46bEyd7BXBBJTfIo8S0S
gUdgRM6JDP5/zcZbafmjNOR+Cb3IDFyeVUc20wIBIwKCAQEA6FP5LSkicwSDwI1U
zN6qUo8iADqzsl9hzhFq5jgms326HcHVIAgo/1M0BiSB5nvFeTFfhcog+1Np6Y0+
a1/EHfeCWKGZexbi00efnm15HwiEm3LDv5dTp99P5VbUYox8N8waCM4s1Zs7VwwU
e/iPFtAAq9HDvENvF2ISj+5A9vX4r/YXN5sEdGoZ1o2I7P1zvjiDe4Op+wd+98fL
S55NHjqCmGsuouDOh8R8j0Gk/6BLSDWMD8Z/yxQCN5s10YA5VFDkyBV1ELS6KX/l
GBZclNRjJXmQwvyTseMcVOx5nWQbXQeCd/T5vwSYV5MTWrdpYi1vpp6CyIP7rxnI
OQfsWwKBgQD/Zn0aB3jT9fwuNdRqZBMV8D/XAHU3Rzmam7mQMsuR9y8GR0nWnoqr
QpqEj6AVIwA5dvlNF5iDJPD0PWKCBwHenHbuV+/MfnEciJvO7g+eG+S6snyj9kxR
cVRnUeVuqDzuCdSsYiRo8YzsGAX2rtGm1BCNMp7PpyF9wcQHkEAVNQKBgQDvuQRs
BcqqTa8V3I9nFXh91frZlwVlieRZjrTFdQlwAb7EekAFF+CKPiNrHDYNtQ39Nevi
Krkz3RdgnON80IS2Kkb1WKkqdMgTBX5mJ+DXN8MYRMK4Uc7qXagXOkZ7kr8evEkj
lJe5/4+01w5PjN2L3gWbi3VU7ozlUpSjAspE5wKBgQCvIbTepgm16oEJvoMHIA0W
W5l9fKgl57J4pUwLG4RG1WIS7w4Pgqg669erWyvxPJJwjBip5EtSnPz/QAkItFkN
rR5aSu2Tiecpgj70S3hsauX8XSJEi6IL9fC74GLPiU5aFV6iF2lsiGCh5JZgAtjn
bNgmTpjI56Hv1VM4YuodKwKBgQCCIpwAIGa0OMzCuY+s/QblOaVuzlNjAbZ5wn9j
4HLWZ1juUP4upo/WBHmgi6hQlXyfZmobsMrwRNItIffWCsuzWMdvPsI7nns9hqOz
zIFe48GuFrLZFnejzHExLkOE6UMt8S8Er8AUg2tE6cXwq441/C7uCeCb0fS3APGa
UfjGUQKBgQDUwKcgPyFrIlMJb9omcpqvFRqs3APhNameQBChF37kMaMyrlTg5lVR
7bemFY3/TWouMYielx4hOJ4T9pclCgqguEahR5eY0+6th+J8arFrccaQz93nTwpN
8h0i1Cq1ZqzKUkQUxFfvxtfim1nw3sh9NONghTAMJWIjUegr306zjw==
-----END RSA PRIVATE KEY-----',
  }

  exec { 'Add-the-project':
    command  => '/usr/bin/rd-project -a create -p test',
    user     => 'rundeck',
    creates  => '/var/lib/rundeck/.TEST_PROJECT_ADD',
    require  => User['rundeck'],
  }

  file { '/var/lib/rundeck/.TEST_PROJECT_ADD':
    ensure   => file,
    content  => 'DO NOT DELETE THIS FILE, IT IS A BLOCK FOR A EXEC IN PUPPET',
    require  => Exec['Add-the-project'],
  }

  file { '/var/lib/rundeck/service-sshd-restart.xml':
    ensure   => file,
    owner    => 'rundeck',
    group    => 'rundeck',
    require  => [Exec['Add-the-project'],
                 Service['rundeckd']
                ],
    content  => '<joblist>
  <job>
    <name>Restart sshd service?</name>
    <description>Runs the unix service command</description>
    <group>sysadm/users</group>
    <context>
      <project>test</project>
    </context>
    <sequence>
      <command>
        <!-- the Unix \'service restart\' command -->
        <exec>ssh 192.168.1.101 \'sudo /sbin/service sshd restart\'</exec>
      </command>
     </sequence>
    <nodefilters excludeprecedence="true">
      <include>
        <os-family>unix</os-family>
      </include>
    </nodefilters>
    <dispatch>
      <threadcount>1</threadcount>
      <keepgoing>true</keepgoing>
    </dispatch>
  </job>
</joblist>
',
  }

  exec { 'Add-the-job':
    command  => '/usr/bin/rd-jobs load -p test --file /var/lib/rundeck/service-sshd-restart.xml',
    user     => 'rundeck',
    creates  => '/var/lib/rundeck/.TEST_JOB_ADD',
    require  => File['/var/lib/rundeck/service-sshd-restart.xml'],
  }

  file { '/var/lib/rundeck/.TEST_JOB_ADD':
    ensure   => file,
    content  => 'DO NOT DELETE THIS FILE, IT IS A BLOCK FOR A EXEC IN PUPPET',
    require  => Exec['Add-the-job'],
  }

}