namespace :accounts do
  desc "remove an account"
  task :remove => :environment do 
    a = Account.find_by_email! ENV['email']
    puts "#{a.email} found..."
    a.personas.each do | p | 
      Persona.delete p.id
      puts "...persona deleted"
    end
    Account.delete a.id 
    puts "...account deleted"
  end
end