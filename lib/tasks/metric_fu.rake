begin
  require 'metric_fu'
  MetricFu.configuration.configure_graph_engine(:highcharts)
  MetricFu::Configuration.run do |config|
    config.configure_metric(:rcov) do |rcov|
      rcov.coverage_file = MetricFu.run_path.join("coverage/rcov/rcov.txt")
      rcov.enable
      rcov.activate
    end
  end
rescue LoadError
end
