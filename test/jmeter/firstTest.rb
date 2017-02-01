require 'ruby-jmeter'

def generate_report(url, email, password, count)
  uri = URI(url)
  domain, port = uri.host, uri.port
  test do
    threads count: count do
      defaults domain: domain, port: port
      cookies policy: 'rfc2109', clear_each_iteration: true

        visit name: 'login page', url: '/users/sign_in' do
          extract name: 'csrf-token', xpath: "//meta[@name='csrf-token']/@content", tolerant: true
          extract name: 'csrf-param', xpath: "//meta[@name='csrf-param']/@content", tolerant: true
        end

        http_header_manager name: 'X-CSRF-Token', value: '${csrf-token}'

        submit name: '/users/sign_in', url: '/users/sign_in',
          fill_in: {
            '${csrf-param}' => '${csrf-token}',
            'user[email]' => email,
            'user[password]' => password,
          }

      view_results_in_table
      view_results_tree
      graph_results
      aggregate_graph
    end
  end.jmx
end

url = 'http://localhost:3000/'
email = 'przemek903@gazeta.pl'
password = '311090'
count = 10
generate_report(url, email, password, count)