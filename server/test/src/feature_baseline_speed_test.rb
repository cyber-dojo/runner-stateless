require_relative 'test_base'

class BaselineSpeedTest < TestBase

  def self.hex_prefix
    '15964'
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -
  # baseline speed
  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  multi_os_test '8A6',
  'baseline speed' do
    in_kata_as('salmon') {
      assert_baseline_speed
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  def assert_baseline_speed
    timings = []
    (1..5).each do
      started_at = Time.now
      assert_cyber_dojo_sh('true')
      stopped_at = Time.now
      diff = Time.at(stopped_at - started_at).utc
      secs = diff.strftime("%S").to_i
      millisecs = diff.strftime("%L").to_i
      timings << (secs * 1000 + millisecs)
    end
    mean = timings.reduce(0, :+) / timings.size
    assert mean < max=1600, "mean=#{mean}, max=#{max}"
  end

end