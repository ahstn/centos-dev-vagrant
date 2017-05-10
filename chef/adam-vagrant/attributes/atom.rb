default['atom']['repo']['url']    = 'https://copr-be.cloud.fedoraproject.org/results/mosquito/atom/epel-7-$basearch/'
default['atom']['repo']['gpgkey'] = 'https://copr-be.cloud.fedoraproject.org/results/mosquito/atom/pubkey.gpg'

default['atom']['repo']['plugins'] = [
  'linter',
  'linter-ui-default',
  'busy-signal',
  'intensions',
  'linter-foodcritic',
  'linter-rubocop'
]
