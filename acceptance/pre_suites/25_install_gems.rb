test_name "install required gems on controller" do
  # gem path is used to find ras
  step "install gem-path" do
    on controller, "#{BOLT_BIN_DIR}/gem install gem-path"
  end
end
