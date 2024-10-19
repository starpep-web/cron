class TestJob
  def cron_expression
    '* * * * *'
  end

  def run
    puts 'I am alive.'
  end
end