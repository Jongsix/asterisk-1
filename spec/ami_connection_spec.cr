require "./spec_helper"

describe Asterisk::AMI do
  Spec.before_each do
    # less noicy, please
    # Asterisk.logger.level = Logger::FATAL
    # Ensure that asterisk is up and running for each test
    unless Asterisk::Server.running?
      Asterisk::Server.start
      # let Asterisk boot
      sleep 5.seconds
    end
  end

  # Testing connectivity with AMI TCPSocket
  describe "#connectivity" do
    it "should throw error if connecting to the incorrect AMI instance" do
      ami = Asterisk::AMI.new username: "incorrect", secret: "incorrect"
      expect_raises(Asterisk::AMI::LoginError) do
        ami.login
      end
    end

    it "should successfully connect with correct credentials" do
      # credentials should be specified in /etc/asterisk/manager.conf
      ami = Asterisk::AMI.new username: "asterisk.cr", secret: "asterisk.cr"
      ami.login
      ami.connected?.should be_true
      ami.logoff
    end

    it "should successfully connect and disconnect" do
      ami = Asterisk::AMI.new username: "asterisk.cr", secret: "asterisk.cr"
      ami.login
      ami.connected?.should be_true
      ami.logoff
      ami.connected?.should be_false
    end

    it "should change 'connected?' state if connection with AMI get broken" do
      ami = Asterisk::AMI.new username: "asterisk.cr", secret: "asterisk.cr"
      ami.login
      ami.connected?.should be_true
      sleep 2.seconds
      Asterisk::Server.kill
      Asterisk::Server.running?.should be_false
      ami.connected?.should be_false
      ami.logoff
    end

    it "should not let to login if asterisk is not yet fully booted" do
      Asterisk::Server.kill
      Asterisk::Server.running?.should be_false
      Asterisk::Server.start
      # nmap dependency
      while Asterisk::Server.port_closed?
        sleep 0.01
      end
      ami = Asterisk::AMI.new username: "asterisk.cr", secret: "asterisk.cr"
      expect_raises(Asterisk::AMI::NotBootedError) do
        ami.login
      end
    end
  end
end
