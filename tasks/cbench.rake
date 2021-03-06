require 'rake/clean'

VENDOR = File.expand_path('../../vendor', __FILE__)
VENDOR_OPENFLOW = File.join(VENDOR, 'openflow-1.0.0')
VENDOR_OFLOPS = File.join(VENDOR, 'oflops-0.03.trema1')

CBENCH = File.join(VENDOR_OFLOPS, 'cbench/cbench')
OPENFLOW_H = File.join(VENDOR_OPENFLOW, 'include/openflow/openflow.h')

desc 'Build cbench executable'
task 'vendor:cbench' => CBENCH
file CBENCH => OPENFLOW_H do
  sh "tar xzf #{VENDOR_OFLOPS}.tar.gz -C #{VENDOR}"
  cd VENDOR_OFLOPS do
    sh "./configure --with-openflow-src-dir=#{VENDOR_OPENFLOW}"
    sh 'make'
  end
end

CLEAN << VENDOR_OFLOPS

file OPENFLOW_H do
  sh "tar xzf #{VENDOR_OPENFLOW}.tar.gz -C #{VENDOR}"
end

CLEAN << VENDOR_OPENFLOW
