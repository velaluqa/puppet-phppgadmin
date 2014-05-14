require 'spec_helper'

describe 'phppgadmin', type: :class do
  context 'with default parameters' do
    it do
      should contain_vcsrepo('/srv/phppgadmin').with(
               ensure: :present,
               provider: 'git',
               source: 'git://github.com/phppgadmin/phppgadmin.git',
               user: 'www-data',
               revision: 'origin/REL_5-1')
    end
    it do
      should contain_file('phppgadmin-conf').with(
               owner: 'www-data',
               path: '/srv/phppgadmin/conf/config.inc.php')
    end
  end

  context 'with custom parameters' do
    let :params do
      {
        path: '/srv/pgadmin',
        user: 'custom-user',
        revision: 'origin/master'
      }
    end

    it do
      should contain_vcsrepo('/srv/pgadmin').with(
               ensure: :present,
               provider: 'git',
               source: 'git://github.com/phppgadmin/phppgadmin.git',
               user: 'custom-user',
               revision: 'origin/master')
    end
    it do
      should contain_file('phppgadmin-conf').with(
               owner: 'custom-user',
               path: '/srv/pgadmin/conf/config.inc.php')
    end
  end
end
