#
# Cookbook Name:: alltherubies
# Recipe:: default
#
# Copyright 2012, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

cores         = node['cpu']['total'].to_i

system_rubies = %w(
  1.9.3-p551
  2.0.0-p645
  2.1.6
  2.2.2
  jruby-1.7.19
)

include_recipe "java"

if %{ubuntu debian}.include?(node['platform'])
  package "default-jre-headless"
end

system_rubies.each do |rubie|
  ruby_build_ruby rubie do
    environment({ 'MAKE_OPTS' => "-j #{cores + 1}" })
  end
end
