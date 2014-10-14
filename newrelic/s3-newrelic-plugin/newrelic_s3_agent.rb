#! /usr/bin/env ruby

# An agent that collects metrics
# From S3 metadata

# Requires ruby >= 1.9

require "rubygems"
require "bundler/setup"
require "newrelic_plugin"
require "aws-sdk"

module S3NewRelicAgent

    class Agent < NewRelic::Plugin::Agent::Base

        agent_guid "org.edx.s3watcher"
        agent_version "0.0.1"
        agent_config_options :s3_access_key_id, :s3_secret_access_key, :s3_bucket_name, :s3_region

        agent_human_labels("S3 Agent") { "sample" }

        def setup_metrics
            AWS.config(access_key_id: s3_access_key_id, secret_access_key: s3_secret_access_key, region: s3_region)
            I18n.enforce_available_locales = false


            @aws_s3 = AWS::S3.new

        end

        def get_s3_bucket_object_count

            # Excluded for now but leaving abstraction for later:
            # gathering stats for multiple buckets.

            bucket = @aws_s3.buckets[s3_bucket_name]
            return bucket.objects.count

        end

        def poll_cycle

            report_metric "Number of bucket objects", "Objects", get_s3_bucket_object_count
        end


    end
#    TODO: Test these two approaches to installing the agent
#    NewRelic::Plugin::Setup.install_agent :s3, S3NewRelicAgent
    NewRelic::Plugin::Config.config.agents.keys.each do |agent|
        NewRelic::Plugin::Setup.install_agent agent, S3NewRelicAgent
    end

    NewRelic::Plugin::Run.setup_and_run

end
