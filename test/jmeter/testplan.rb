require 'ruby-jmeter'
test do
  threads count: 10 do
    visit name: 'Login', url: 'http://localhost:3000'
    visit name: 'Dostępność', url: 'http://localhost:3000/analysis/availability'
    visit name: 'Dostępność dla stacji', url: 'http://localhost:3000/analysis/availability?stationName=PKP%20Ursus'
  end
  view_results_in_table
  view_results_tree
  graph_results
  aggregate_graph
end.jmx(file: "avail.jmx")