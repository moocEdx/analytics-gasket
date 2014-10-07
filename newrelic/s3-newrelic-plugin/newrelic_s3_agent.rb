#! /usr/bin/env ruby

# An agent that collects metrics
# From S3 metadata

require "rubygems"
require "bundler/setup"
require "newrelic_plugin"

module S3NewRelicAgent

class S3Agent < NewRelic::Plugin::Agent::Base
  # stuff

  def start_metric_collection_vars

  end

  def poll_cycle

  end

NewRelic::Plugin::Setup.install_agent # params?

NewRelic::Plugin::Run.setup_and_run

end
