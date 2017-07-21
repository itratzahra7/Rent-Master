namespace :active_industries do
  desc "Activate the industries which are inactivate"
  task activate_industries: :environment do
    Industry.where( status: 'inactive' ).update_all( status: 'active' )
  end
end
