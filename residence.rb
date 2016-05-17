require 'yaml'

yaml_path = File.join(File.dirname(__FILE__), "travel_history.yaml")
history = YAML::load(File.open(yaml_path))
culInfo = System::Globalization::CultureInfo.InvariantCulture

days_in_russia = 365

history["travel_dates"].each do |travel|
  travel_start = System::DateTime.ParseExact(travel["there"], "dd/MM/yyyy", culInfo)
  tmp_date = travel_start
  travel_end = System::DateTime.ParseExact(travel["back"], "dd/MM/yyyy", culInfo)
  if System::DateTime.now.Subtract(travel_end).TotalDays < 365
    while (tmp_date <= travel_end)
      if tmp_date >= System::DateTime.now.Subtract(System::TimeSpan.new(365, 0, 0, 0))
        days_in_russia -= 1
      end
      tmp_date = tmp_date.AddDays(1)
    end
  end
end

puts "days spent in Russia within the last year: #{days_in_russia}"
puts "can travel for #{365/2-(365-days_in_russia)} days"
# time = System::DateTime.ParseExact("09/04/2016", "dd/MM/yyyy", culInfo)
# puts time