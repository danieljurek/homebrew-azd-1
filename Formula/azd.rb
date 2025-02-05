class Azd < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  
  if Hardware::CPU.intel?
    url "https://djurekazd.blob.core.windows.net/arm64test/azd-darwin-amd64.zip"
    sha256 "07c07588c2be7d632e824a56dfb1a3b90cdcddc46a8e93d3db232d0c69458666"
  elsif Hardware::CPU.arm?
    url "https://djurekazd.blob.core.windows.net/arm64test/azd-darwin-arm64.zip"
    sha256 "86b3b547757bda41f204a3e794d6c61d229964a10e87371052c737a868e7825f"
  end

  version "1.2.3-dev.1"
  
  license "MIT"

  def install
    if Hardware::CPU.intel?
      bin.install "azd-darwin-amd64" => "azd"
    elsif Hardware::CPU.arm?
      bin.install "azd-darwin-arm64" => "azd"
    end

    (bin/".installed-by.txt").write "brew"
  end

  def caveats
    caveat = <<~EOS
      The #{desc} collects usage data and sends that usage data to Microsoft in order to help us improve your experience.
      You can opt-out of telemetry by setting the AZURE_DEV_COLLECT_TELEMETRY environment variable to 'no' in the shell you use.

      Read more about #{desc} telemetry: https://github.com/Azure/azure-dev#data-collection

      azd may download binaries to ~/.azd/bin and, depending on how azd was used on this machine,
      may download binaries to other users' home directories in their .azd/bin directory.
      These binaries will need to be removed manually upon uninstall.
      To remove such binaries from your home directory, run 'rm -rf ~/.azd/bin'.

    EOS
    caveat
  end

  test do
    version_output = shell_output "#{bin}/azd version"
    assert_equal 0, $CHILD_STATUS.exitstatus
    assert_match "azd version", version_output
  end
end

