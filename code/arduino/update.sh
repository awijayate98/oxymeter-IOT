#!/bin/bash

# Skrip menu sederhana untuk konfigurasi Gateway LoRa

# Fungsi untuk mengonfigurasi Gateway Singapore
configure_singapore() {
echo "Konfigurasi Gateway Singapore"
# Tambahkan konfigurasi yang diperlukan untuk Gateway Indonesia
echo "Menyiapkan konfigurasi untuk Gateway Singapore..."
# Mengosongkan file lorafwd.toml sebelum menulis konfigurasi baru
> /etc/lorafwd.toml
cat <<EOF > /etc/lorafwd.toml
# The LoRa forwarder configuration file.
#
# This configuration file is formatted using the TOML v0.5.0 language:
#  https://github.com/toml-lang/toml/blob/master/versions/en/toml-v0.5.0.md

[ gateway ]

# The gateway identifier. Used to identify the gateway inside the network. This
# identifier is 64 bits long. It could be expressed in hexadecimal for better
# readability.
#
# Type:    integer
# Example: 1194684 or 0x123abc or 0o4435274 or 0b100100011101010111100
# Default: 0
#
#id = 0xFFFFFFFFFFFFFFFF

[ filter ]

# Whether or not an uplink message with a valid CRC will be forwarded.
#
# Type:    boolean
# Example: false
# Default: true
#
#crc.valid = true

# Whether or not an uplink message with an invalid CRC will be forwarded.
#
# Type:    boolean
# Example: true
# Default: false
#
#crc.invalid = false

# Whether or not an uplink message without CRC will be forwarded.
#
# Type:    boolean
# Example: true
# Default: false
#
#crc.none = false

# Whether or not a LoRaWAN downlink will be forwarded as an uplink message.
#
# Type:    boolean
# Example: true
# Default: false
#
#lorawan.downlink = false

# Whether or not a LoRaWAN uplink message with a matching device address will
# be forwarded.
#
# Type:    string or array of strings using CIDR notation
# Example: [ "0x12000000/8", "!0x12340000/16", "0x34000000/8" ]
# Default: "" (everything allowed)
#
#lorawan.netid = [ "0x24000000/7" ]

# Whether or not a LoRaWAN uplink message with a matching join EUI will
# be forwarded.
#
# Type:    string or array of strings using CIDR notation
# Example: [ "0x1200000000000000/8", "!0x1234000000000000/16" ]
# Default: "" (everything allowed)
#
#lorawan.joineui = [ "0x7076FF0001000000/40" ]

# Whether or not a LoRaWAN uplink message with a matching device EUI will
# be forwarded.
#
# Type:    string or array of strings using CIDR notation
# Example: [ "0x1200000000000000/8", "!0x1234000000000000/16" ]
# Default: "" (everything allowed)
#
#lorawan.deveui = [ "0x7076FF0000000000/40" ]

# Whether or not a LoRaWAN proprietary message with be forwarded.
#
# Type:    boolean
# Example: false
# Default: true
#
#lorawan.proprietary = true

[ database ]

# Whether or not a persistent database will store the incoming messages until
# they will be sent and acknowledged.
#
# Type:    boolean
# Example: true
# Default: false
#
#enable = true

# The maximum number of messages allowed to be stored in the database. When
# full the newest message will replace the oldest one.
#
# Type:    integer
# Example: 20000
# Default: 200
#
#limit.messages = 200

# The minimum delay between two database fetch. To allow incoming messages
# to be aggregated before to be sent.
#
# Type:    integer (in milliseconds)
# Example: 1000
# Default: 100
#
#delay.cooldown = 1000

[ gwmp ]

# The internet host where the gateway should connect. The node can be either a
# fully qualified domain name or an IP address (IPv4 or IPv6).
#
# Type:    string
# Example: "myhost.example.com" or "123.45.67.89" or "2001:db8::1234"
# Default: "localhost"
#
#node = "localhost"
node = "asia.srv.sindconiot.com"

# The timeout in seconds before GWMP services consider that host/node is not connected
#
# Type: integer
# Example: 5
# Default: 3
#
#timeout = 3

# The GWMP services can be a service name (see services(5)) or an integer and,
# in this case, refers to a network port.

# The service where the gateway should push uplink messages.
#
# Type:    string or integer
# Example: "https" or 1700
# Default: 0
#
#service.uplink = 1700
service.uplink = 1700

# The service where the gateway should pull downlink messages.
#
# Type:    string or integer
# Example: "https" or 1700
# Default: 0
#
#service.downlink = 1700
service.downlink = 1700

# The heartbeat period. Used to keep the firewall open.
#
# Type:    integer (in seconds)
# Example: 30
# Default: 10
#
#period.heartbeat = 10
period.heartbeat = 60

# The statistics period. Used to send statistics.
#
# Type:    integer (in seconds)
# Example: 10
# Default: 30
#
#period.statistics = 30
period.statistics = 300

# The number of timed out messages which will automatically trigger a network
# socket restart. Used to monitor the connection.
#
# Type:    boolean or integer (false = 0 = disabled) (true = 10)
# Example: 3
# Default: true
#
autorestart = 50

# The maximum datagram size for uplink messages. The datagram includes the GWMP
# header and payload.
#
# Type:    integer
# Example: 50000
# Default: 20000
#
#limit.datagram = 65507

# The endpoint to control the LoRa daemon. Used to request statistics.
#
# Type:    string
# Example: "tcp://localhost:3333"
# Default: "ipc:///var/run/lora/lorad"
#
#lorad.control = "ipc:///var/run/lora/lorad"

# Tx power used is reported in TX_ACK payload when warn "TX_POWER" field available: txpk_ack.warn and txpk_ack.power
# instead of txpk_ack.error when a tx packet is sent with a power different from the expected one.
#
# Type:    boolean
# Example: false
# Default: false
#
#report_tx_power = false

[ api ]

# The API use ZeroMQ as transport layer. More informations about ZeroMQ
# endpoints format can be found here:
#
# http://api.zeromq.org/4-2:zmq-connect

# The endpoints for the uplink channel. Used to receive uplink messages.
#
# Type:    string or array of strings
# Example: "tcp://localhost:1111"
# Default: "ipc:///var/run/lora/uplink"
#
#uplink = [ "ipc:///var/run/lora/uplink", "tcp://localhost:1111" ]

# The endpoints for the downlink channel. Used to send downlink messages.
#
# Type:    string or array of strings
# Example: "tcp://localhost:2222"
# Default: "ipc:///var/run/lora/downlink"
#
#downlink = [ "ipc:///var/run/lora/downlink", "tcp://localhost:2222" ]

# The endpoints for the control channel. Used to receive control request.
#
# Type:    string or array of strings
# Example: "tcp://eth0:4444"
# Default: "ipc:///var/run/lora/lorafwd"
#
#control = [ "ipc:///var/run/lora/lorafwd", "tcp://eth0:4444" ]

# The filters for the uplink channel. Used to subscribe to uplink messages.
#
# The filters can handle raw binary (by using unicode) or keywords. The special
# empty filter ("") subscribe to all incoming messages.
#
# Keywords are case-insensitive and are one of these:
# - "lora"
# - "gfsk" or "fsk"
# - "event" (for ease of use, lorafwd always subscribe to event messages)
#
# Type:    string or array of strings
# Example: [ "\u000A", "keyword" ]
# Default: ""
#
#filters = [ "lora", "gfsk" ]

EOF
sleep 2

}


# Fungsi untuk mengonfigurasi Gateway Indonesia
configure_indonesia() {
clear
echo "Konfigurasi Gateway Indonesia"
# Tambahkan konfigurasi yang diperlukan untuk Gateway Indonesia
echo "Menyiapkan konfigurasi untuk Gateway Indonesia..."
# Mengosongkan file lorafwd.toml sebelum menulis konfigurasi baru
> /etc/lorafwd.toml
cat <<EOF > /etc/lorafwd.toml
# The LoRa forwarder configuration fileswe.
#
# This configuration file is formatted using the TOML v0.5.0 language:
#  https://github.com/toml-lang/toml/blob/master/versions/en/toml-v0.5.0.md

[ gateway ]

# The gateway identifier. Used to identify the gateway inside the network. This
# identifier is 64 bits long. It could be expressed in hexadecimal for better
# readability.
#
# Type:    integer
# Example: 1194684 or 0x123abc or 0o4435274 or 0b100100011101010111100
# Default: 0
#
#id = 0xFFFFFFFFFFFFFFFF

[ filter ]

# Whether or not an uplink message with a valid CRC will be forwarded.
#
# Type:    boolean
# Example: false
# Default: true
#
#crc.valid = true

# Whether or not an uplink message with an invalid CRC will be forwarded.
#
# Type:    boolean
# Example: true
# Default: false
#
#crc.invalid = false

# Whether or not an uplink message without CRC will be forwarded.
#
# Type:    boolean
# Example: true
# Default: false
#
#crc.none = false

# Whether or not a LoRaWAN downlink will be forwarded as an uplink message.
#
# Type:    boolean
# Example: true
# Default: false
#
#lorawan.downlink = false

# Whether or not a LoRaWAN uplink message with a matching device address will
# be forwarded.
#
# Type:    string or array of strings using CIDR notation
# Example: [ "0x12000000/8", "!0x12340000/16", "0x34000000/8" ]
# Default: "" (everything allowed)
#
#lorawan.netid = [ "0x24000000/7" ]

# Whether or not a LoRaWAN uplink message with a matching join EUI will
# be forwarded.
#
# Type:    string or array of strings using CIDR notation
# Example: [ "0x1200000000000000/8", "!0x1234000000000000/16" ]
# Default: "" (everything allowed)
#
#lorawan.joineui = [ "0x7076FF0001000000/40" ]

# Whether or not a LoRaWAN uplink message with a matching device EUI will
# be forwarded.
#
# Type:    string or array of strings using CIDR notation
# Example: [ "0x1200000000000000/8", "!0x1234000000000000/16" ]
# Default: "" (everything allowed)
#
#lorawan.deveui = [ "0x7076FF0000000000/40" ]

# Whether or not a LoRaWAN proprietary message with be forwarded.
#
# Type:    boolean
# Example: false
# Default: true
#
#lorawan.proprietary = true

[ database ]

# Whether or not a persistent database will store the incoming messages until
# they will be sent and acknowledged.
#
# Type:    boolean
# Example: true
# Default: false
#
#enable = true

# The maximum number of messages allowed to be stored in the database. When
# full the newest message will replace the oldest one.
#
# Type:    integer
# Example: 20000
# Default: 200
#
#limit.messages = 200

# The minimum delay between two database fetch. To allow incoming messages
# to be aggregated before to be sent.
#
# Type:    integer (in milliseconds)
# Example: 1000
# Default: 100
#
#delay.cooldown = 1000

[ gwmp ]

# The internet host where the gateway should connect. The node can be either a
# fully qualified domain name or an IP address (IPv4 or IPv6).
#
# Type:    string
# Example: "myhost.example.com" or "123.45.67.89" or "2001:db8::1234"
# Default: "localhost"
#
#node = "localhost"
node = "indonesia.sindconiot.com"

# The timeout in seconds before GWMP services consider that host/node is not connected
#
# Type: integer
# Example: 5
# Default: 3
#
#timeout = 3

# The GWMP services can be a service name (see services(5)) or an integer and,
# in this case, refers to a network port.

# The service where the gateway should push uplink messages.
#
# Type:    string or integer
# Example: "https" or 1700
# Default: 0
#
#service.uplink = 1700
service.uplink = 1700

# The service where the gateway should pull downlink messages.
#
# Type:    string or integer
# Example: "https" or 1700
# Default: 0
#
#service.downlink = 1700
service.downlink = 1700

# The heartbeat period. Used to keep the firewall open.
#
# Type:    integer (in seconds)
# Example: 30
# Default: 10
#
#period.heartbeat = 10
period.heartbeat = 60

# The statistics period. Used to send statistics.
#
# Type:    integer (in seconds)
# Example: 10
# Default: 30
#
#period.statistics = 30
period.statistics = 300

# The number of timed out messages which will automatically trigger a network
# socket restart. Used to monitor the connection.
#
# Type:    boolean or integer (false = 0 = disabled) (true = 10)
# Example: 3
# Default: true
#
autorestart = 50

# The maximum datagram size for uplink messages. The datagram includes the GWMP
# header and payload.
#
# Type:    integer
# Example: 50000
# Default: 20000
#
#limit.datagram = 65507

# The endpoint to control the LoRa daemon. Used to request statistics.
#
# Type:    string
# Example: "tcp://localhost:3333"
# Default: "ipc:///var/run/lora/lorad"
#
#lorad.control = "ipc:///var/run/lora/lorad"

# Tx power used is reported in TX_ACK payload when warn "TX_POWER" field available: txpk_ack.warn and txpk_ack.power
# instead of txpk_ack.error when a tx packet is sent with a power different from the expected one.
#
# Type:    boolean
# Example: false
# Default: false
#
#report_tx_power = false

[ api ]

# The API use ZeroMQ as transport layer. More informations about ZeroMQ
# endpoints format can be found here:
#
# http://api.zeromq.org/4-2:zmq-connect

# The endpoints for the uplink channel. Used to receive uplink messages.
#
# Type:    string or array of strings
# Example: "tcp://localhost:1111"
# Default: "ipc:///var/run/lora/uplink"
#
#uplink = [ "ipc:///var/run/lora/uplink", "tcp://localhost:1111" ]

# The endpoints for the downlink channel. Used to send downlink messages.
#
# Type:    string or array of strings
# Example: "tcp://localhost:2222"
# Default: "ipc:///var/run/lora/downlink"
#
#downlink = [ "ipc:///var/run/lora/downlink", "tcp://localhost:2222" ]

# The endpoints for the control channel. Used to receive control request.
#
# Type:    string or array of strings
# Example: "tcp://eth0:4444"
# Default: "ipc:///var/run/lora/lorafwd"
#
#control = [ "ipc:///var/run/lora/lorafwd", "tcp://eth0:4444" ]

# The filters for the uplink channel. Used to subscribe to uplink messages.
#
# The filters can handle raw binary (by using unicode) or keywords. The special
# empty filter ("") subscribe to all incoming messages.
#
# Keywords are case-insensitive and are one of these:
# - "lora"
# - "gfsk" or "fsk"
# - "event" (for ease of use, lorafwd always subscribe to event messages)
#
# Type:    string or array of strings
# Example: [ "\u000A", "keyword" ]
# Default: ""
#
#filters = [ "lora", "gfsk" ]   
EOF
sleep 2

}

create_lorad_json_singapore() {
    clear
    echo "Membuat file lorad.json di /etc/lorad/"

    # Membuat direktori /etc/lorad/ jika belum ada
    mkdir -p /etc/lorad

    # Menulis konfigurasi lorad.json menggunakan Here Document
    cat <<EOF > /etc/lorad/lorad.json
{
	"SX1301_conf": {
		"lorawan_public": true,
		"antenna_gain": 6,
		"antenna_gain_desc": "Antenna gain, in dBi",
		"insertion_loss": 0.5,
		"insertion_loss_desc": "Insertion loss, in dB",
		"radio_0": {
			"enable": true,
			"freq": 921600000,
			"tx_enable": true,
			"tx_freq_min": 920600000,
			"tx_freq_max": 928000000
		},
		"radio_1": {
			"enable": true,
			"freq": 922400000,
			"tx_enable": false
		},
		"chan_multiSF_0": {
			"desc": "LoRa, 125 kHz, SF 7-12, 921.4 MHz",
			"enable": true,
			"radio": 0,
			"if": -200000
		},
		"chan_multiSF_1": {
			"desc": "LoRa, 125 kHz, SF 7-12, 921.6 MHz",
			"enable": true,
			"radio": 0,
			"if": 0
		},
		"chan_multiSF_2": {
			"desc": "LoRa, 125 kHz, SF 7-12, 921.2 MHz",
			"enable": true,
			"radio": 0,
			"if": -400000
		},
		"chan_multiSF_3": {
			"desc": "LoRa, 125 kHz, SF 7-12, 921.8 MHz",
			"enable": true,
			"radio": 0,
			"if": 200000
		},
		"chan_multiSF_4": {
			"desc": "LoRa, 125 kHz, SF 7-12, 922 MHz",
			"enable": true,
			"radio": 0,
			"if": 400000
		},
		"chan_multiSF_5": {
			"desc": "LoRa, 125 kHz, SF 7-12, 922.2 MHz",
			"enable": true,
			"radio": 1,
			"if": -200000
		},
		"chan_multiSF_6": {
			"desc": "LoRa, 125 kHz, SF 7-12, 922.4 MHz",
			"enable": true,
			"radio": 1,
			"if": 0
		},
		"chan_multiSF_7": {
			"desc": "LoRa, 125 kHz, SF 7-12, 922.6 MHz",
			"enable": true,
			"radio": 1,
			"if": 200000
		},
		"chan_Lora_std": {
			"desc": "LoRa, 250 kHz, SF 7, 922.1 MHz",
			"enable": false,
			"radio": 0,
			"if": -300000,
			"bandwidth": 250000,
			"spread_factor": 7
		},
		"chan_FSK": {
			"desc": "FSK, 125 kHz, 50kbps, 922.7 MHz",
			"enable": false,
			"radio": 0,
			"if": 300000,
			"bandwidth": 125000,
			"datarate": 50000
		}
	},
	"gateway_conf": {
		"beacon_enable": false,
		"beacon_period": 128,
		"beacon_freq_hz": 923400000,
		"beacon_datarate": 9,
		"beacon_bw_hz": 125000,
		"beacon_power": 14,
		"beacon_infodesc": [
			{ "latitude": 0.0, "longitude": 0.0 },
			{ "netid": "0" }
		]
	}
}

EOF

    echo "File lorad.json telah dibuat di /etc/lorad/"
    sleep 2
}

create_lorad_json_indonesia() {
    clear
    echo "Membuat file lorad.json di /etc/lorad/"

    # Membuat direktori /etc/lorad/ jika belum ada
    mkdir -p /etc/lorad

    # Menulis konfigurasi lorad.json menggunakan Here Document
    cat <<EOF > /etc/lorad/lorad.json
{
	"SX1301_conf": {
		"lorawan_public": true,
		"antenna_gain": 6,
		"antenna_gain_desc": "Antenna gain, in dBi",
		"insertion_loss": 0.5,
		"insertion_loss_desc": "Insertion loss, in dB",
		"radio_0": {
			"enable": true,
			"freq": 921600000,
			"tx_enable": true,
			"tx_freq_min": 920600000,
			"tx_freq_max": 928000000
		},
		"radio_1": {
			"enable": true,
			"freq": 922400000,
			"tx_enable": false
		},
		"chan_multiSF_0": {
			"desc": "LoRa, 125 kHz, SF 7-12, 921.4 MHz",
			"enable": true,
			"radio": 0,
			"if": -200000
		},
		"chan_multiSF_1": {
			"desc": "LoRa, 125 kHz, SF 7-12, 921.6 MHz",
			"enable": true,
			"radio": 0,
			"if": 0
		},
		"chan_multiSF_2": {
			"desc": "LoRa, 125 kHz, SF 7-12, 921.2 MHz",
			"enable": true,
			"radio": 0,
			"if": -400000
		},
		"chan_multiSF_3": {
			"desc": "LoRa, 125 kHz, SF 7-12, 921.8 MHz",
			"enable": true,
			"radio": 0,
			"if": 200000
		},
		"chan_multiSF_4": {
			"desc": "LoRa, 125 kHz, SF 7-12, 922 MHz",
			"enable": true,
			"radio": 0,
			"if": 400000
		},
		"chan_multiSF_5": {
			"desc": "LoRa, 125 kHz, SF 7-12, 922.2 MHz",
			"enable": true,
			"radio": 1,
			"if": -200000
		},
		"chan_multiSF_6": {
			"desc": "LoRa, 125 kHz, SF 7-12, 922.4 MHz",
			"enable": true,
			"radio": 1,
			"if": 0
		},
		"chan_multiSF_7": {
			"desc": "LoRa, 125 kHz, SF 7-12, 922.6 MHz",
			"enable": true,
			"radio": 1,
			"if": 200000
		},
		"chan_Lora_std": {
			"desc": "LoRa, 250 kHz, SF 7, 922.1 MHz",
			"enable": false,
			"radio": 0,
			"if": -300000,
			"bandwidth": 250000,
			"spread_factor": 7
		},
		"chan_FSK": {
			"desc": "FSK, 125 kHz, 50kbps, 922.7 MHz",
			"enable": false,
			"radio": 0,
			"if": 300000,
			"bandwidth": 125000,
			"datarate": 50000
		}
	},
	"gateway_conf": {
		"beacon_enable": false,
		"beacon_period": 128,
		"beacon_freq_hz": 923400000,
		"beacon_datarate": 9,
		"beacon_bw_hz": 125000,
		"beacon_power": 14,
		"beacon_infodesc": [
			{ "latitude": 0.0, "longitude": 0.0 },
			{ "netid": "0" }
		]
	}
}

EOF

    echo "File lorad.json telah dibuat di /etc/lorad/"
    sleep 2
}



# Fungsi untuk mengedit file lorad dan lorafwd
edit_lora_files() {
    clear
    echo "Mengedit file lorad dan lorafwd"

    # Mengosongkan file lorad sebelum menulis konfigurasi baru
    > /etc/default/lorad

    # Menulis konfigurasi ke dalam file lorad
    echo "# Configuration file for lorad." > /etc/default/lorad
    echo "" >> /etc/default/lorad
    echo "#### Common configurations." >> /etc/default/lorad
    echo "" >> /etc/default/lorad
    echo "# Disable lorad (default value: no)" >> /etc/default/lorad
    echo 'DISABLE_LORAD="no"' >> /etc/default/lorad
    echo "" >> /etc/default/lorad
    echo "# The extra arguments." >> /etc/default/lorad
    echo 'EXTRA_ARGS="-vv"' >> /etc/default/lorad
    echo "" >> /etc/default/lorad
    echo "# The configuration file." >> /etc/default/lorad
    echo 'CONFIGURATION_FILE="/etc/lorad/lorad.json"' >> /etc/default/lorad
    echo "" >> /etc/default/lorad
    echo "# The FPGA firmware binary filesere." >> /etc/default/lorad
    echo 'FPGA_FIRMWARE_FILE="/usr/share/lorad/fpga_v61.bin"' >> /etc/default/lorad

    # Mengedit file lorafwd (jika diperlukan, bisa ditambahkan)
    # Mengosongkan file lorafwd sebelum menulis konfigurasi baru
    > /etc/default/lorafwd

    # Menulis konfigurasi ke dalam file lorafwd
    echo "# Configuration file for lorafwd." > /etc/default/lorafwd
    echo "" >> /etc/default/lorafwd
    echo "# Disable lorafwd (default value: no)" >> /etc/default/lorafwd
    echo 'DISABLE_LORAFWD="no"' >> /etc/default/lorafwd
    echo "" >> /etc/default/lorafwd
    echo "# The configuration file." >> /etc/default/lorafwd
    echo 'CONFIGURATION_FILE="/etc/lorafwd.toml"' >> /etc/default/lorafwd
    echo "" >> /etc/default/lorafwd
    echo "# The extra argumentsettsd." >> /etc/default/lorafwd
    echo 'EXTRA_ARGS="-vv -p /var/run/lora/lorafwd.pid -s /var/lib/lorafwd/database.sqlite"' >> /etc/default/lorafwd

    sleep 2
}

set_dns_1_1_1_1() {
    echo "Mengatur DNS menjadi 1.1.1.1 dan 1.0.0.1..."

    # Backup file resolv.conf sebelum mengubahnya
    cp /etc/resolv.conf /etc/resolv.conf.backup
    rm /etc/resolv.conf
    # Menulis DNS 1.1.1.1 dan 1.0.0.1 ke file resolv.conf
    echo -e "nameserver 1.1.1.1\nnameserver 1.0.0.1" > /etc/resolv.conf

    # Menambahkan proteksi file dengan chattr +i agar tidak bisa diubah
    chattr +i /etc/resolv.conf
    echo "DNS telah diatur ke 1.1.1.1 dan 1.0.0.1. File resolv.conf telah dilindungi."
    nslookup google.com
}

upgrade_firmware() {
    echo "Memulai upgrade firmware..."

    # 1. Download file firmware .ipk
    FIRMWARE_URL="https://wikikerlink.fr/wirnet-productline/lib/exe/fetch.php?media=resources_multi_hardware:liveburner_5.11.0_klkgw-signed.ipk"
    FIRMWARE_PATH="/user/.updates/liveburner_5.11.0_klkgw-signed.ipk"
    
    echo "Mengunduh firmware dari $FIRMWARE_URL..."
    wget -O $FIRMWARE_PATH "$FIRMWARE_URL"
    
    if [ $? -ne 0 ]; then
        echo "Gagal mengunduh firmware. Pastikan URL benar dan coba lagi."
        return 1
    fi

    # 2. Menyinkronkan data ke disk
    echo "Menyinkronkan data ke disk..."
    sync

    # 3. Melakukan upgrade dengan kerosd -u
    echo "Menjalankan kerosd -u untuk upgrade sistem..."
    kerosd -u

    # 4. Reboot sistem untuk menerapkan perubahan
    echo "Rebooting sistem..."
    reboot
}

# Fungsi untuk menampilkan informasi sistem
cek_system_info() {
    echo "Informasi Sistem:"
    echo "================"
    
    # Menampilkan informasi tentang kernel dan arsitektur sistem
    echo "Kernel dan Arsitektur:"
    uname -a
    echo "================"

    # Menampilkan informasi tentang penggunaan disk
    echo "Penggunaan Disk:"
    df -h
    echo "================"

    # Menampilkan informasi tentang memori
    echo "Memori:"
    free -m
    echo "================"

    # Menampilkan informasi tentang CPU
    echo "Informasi CPU:"
    lscpu
    echo "================"

    # Menampilkan status proses
    echo "Status Proses:"
    top -n 1 | head -n 20
    echo "================"

    # Menampilkan status jaringan
    echo "Status Jaringan:"
    ifconfig -a
    echo "================"

    # Menampilkan informasi versi firmware
    echo "Versi Firmware:"
    if [ -f /tmp/sys_startup_status.json ]; then
        sw_version=$(jq -r '.sw_version' /tmp/sys_startup_status.json)
        echo "Versi firmware saat ini: $sw_version"
    else
        echo "File /tmp/sys_startup_status.json tidak ditemukan."
    fi
    echo "================"

    # Menampilkan konfigurasi gateway
    echo "Konfigurasi Gateway:"
    if [ -f /etc/lorafwd.toml ]; then
        node_value=$(grep -E '^node\s*=' /etc/lorafwd.toml | awk -F ' = ' '{print $2}' | tr -d '"')
        if [[ "$node_value" == "asia.srv.sindconiot.com" ]]; then
            echo "Gateway terhubung ke server Singapore."
        elif [[ "$node_value" == "indonesia.sindconiot.com" ]]; then
            echo "Gateway terhubung ke server Indonesia."
        else
            echo "Konfigurasi node tidak dikenali: $node_value"
        fi
    else
        echo "File /etc/lorafwd.toml tidak ditemukan."
    fi
}

ambil_auth_key() {
  echo "🔹 Mengambil Auth Key..."
  AUTH_KEY=$(curl -sL "https://raw.githubusercontent.com/awijayate98/oxymeter-IOT/refs/heads/master/code/arduino/baca.txt")

  if [ -z "$AUTH_KEY" ]; then
    echo "❌ Gagal mengambil Auth Key! Periksa URL atau repo GitHub."
    exit 1
  fi

  echo "✅ Auth Key berhasil diambil!"
}

# Fungsi untuk mengunduh dan menginstal Tailscale
install_tailscale() {
  TS_VERSION="1.68.0"
  TS_ARCH="arm"
  TS_FILE="tailscale_${TS_VERSION}_${TS_ARCH}.tgz"

  echo "🔹 Mengunduh Tailscale versi $TS_VERSION..."
  wget -q "https://pkgs.tailscale.com/stable/$TS_FILE" -O tailscale.tgz

  if [ ! -f "tailscale.tgz" ]; then
    echo "❌ Gagal mengunduh Tailscale!"
    exit 1
  fi

  tar -xvzf tailscale.tgz || { echo "❌ Ekstraksi gagal!"; exit 1; }

  if [ ! -f "tailscale_1.68.0_arm/tailscale" ] || [ ! -f "tailscale_1.68.0_arm/tailscaled" ]; then
    echo "❌ File Tailscale tidak ditemukan setelah ekstraksi!"
    exit 1
  fi

  cp tailscale_1.68.0_arm/tailscale /usr/sbin/
  cp tailscale_1.68.0_arm/tailscaled /usr/sbin/
  chmod +x /usr/sbin/tailscale /usr/sbin/tailscaled

  echo "✅ Tailscale berhasil diinstal!"
}

# Fungsi untuk menjalankan Tailscale
jalankan_tailscale() {
  echo "🔹 Menjalankan Tailscale..."
  /usr/sbin/tailscaled --tun=userspace-networking &

  sleep 10  # Tunggu hingga tailscaled aktif

  if [ -n "$AUTH_KEY" ]; then
    /usr/sbin/tailscale up --authkey=tskey-auth-"$AUTH_KEY"
    echo "✅ Tailscale berhasil dikonfigurasi!"
  else
    echo "❌ Auth Key kosong atau tidak valid."
    exit 1
  fi
}

add_crontab_entry() {
  CRON_JOB="@reboot /usr/sbin/tailscaled --tun=userspace-networking; sleep 10; AUTH_KEY=\"tskey-auth\$(curl -sL 'https://raw.githubusercontent.com/awijayate98/oxymeter-IOT/master/code/arduino/baca.txt')\" && echo \"Menggunakan Auth Key: \$AUTH_KEY\" >> /var/log/tailscale.log && /usr/sbin/tailscale up --authkey=\"\$AUTH_KEY\" >> /var/log/tailscale.log 2>&1

*/5 * * * * pgrep tailscaled > /dev/null || (/usr/sbin/tailscaled --tun=userspace-networking; sleep 10; AUTH_KEY=\"tskey-auth\$(curl -sL 'https://raw.githubusercontent.com/awijayate98/oxymeter-IOT/master/code/arduino/baca.txt')\" && echo \"Menggunakan Auth Key: \$AUTH_KEY\" >> /var/log/tailscale.log && /usr/sbin/tailscale up --authkey=\"\$AUTH_KEY\" >> /var/log/tailscale.log 2>&1)"

  # Menambahkan ke crontab tanpa menghapus yang lama
  (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

  echo "✅ Crontab berhasil diperbarui! Perintah baru telah ditambahkan."
}


setupstep2() {
ambil_auth_key
install_tailscale
jalankan_tailscale
add_crontab_entry

}
# Fungsi menampilkan menu pilihan
main_menu() {
    clear
    
    # Mengambil versi firmware dari file JSON tanpa jq
    firmware_version=$(grep -oP '"sw_version"\s*:\s*"\K[^"]+' /tmp/sys_startup_status.json)
echo -e "\033[31m"  # Mengubah teks menjadi merah
echo "
▗▄▄▄▖ ▗▄▖▗▄▄▄▖    ▗▖ ▗▖▗▄▄▖ ▗▄▄▄▖ ▗▄▖  ▗▄▄▖▗▄▄▄▖    ▗▄▄▄▖▗▖  ▗▖▗▄▄▄   ▗▄▖ ▗▖  ▗▖▗▄▄▄▖ ▗▄▄▖ ▗▄▖ 
  █  ▐▌ ▐▌ █      ▐▌▗▞▘▐▌ ▐▌▐▌   ▐▌ ▐▌▐▌     █        █  ▐▛▚▖▐▌▐▌  █ ▐▌ ▐▌▐▛▚▖▐▌▐▌   ▐▌   ▐▌ ▐▌
  █  ▐▌ ▐▌ █      ▐▛▚▖ ▐▛▀▚▖▐▛▀▀▘▐▛▀▜▌ ▝▀▚▖  █        █  ▐▌ ▝▜▌▐▌  █ ▐▌ ▐▌▐▌ ▝▜▌▐▛▀▀▘ ▝▀▚▖▐▛▀▜▌
▗▄█▄▖▝▚▄▞▘ █      ▐▌ ▐▌▐▌ ▐▌▐▙▄▄▖▐▌ ▐▌▗▄▄▞▘▗▄█▄▖    ▗▄█▄▖▐▌  ▐▌▐▙▄▄▀ ▝▚▄▞▘▐▌  ▐▌▐▙▄▄▖▗▄▄▞▘▐▌ ▐▌
"
echo -e "\033[97m" 
echo "
 ▗▄▄▖ ▗▄▖▗▄▄▄▖▗▄▄▄▖▗▖ ▗▖ ▗▄▖▗▖  ▗▖    ▗▖ ▗▖▗▄▄▖ ▗▄▄▄   ▗▄▖▗▄▄▄▖▗▄▄▄▖                           
▐▌   ▐▌ ▐▌ █  ▐▌   ▐▌ ▐▌▐▌ ▐▌▝▚▞▘     ▐▌ ▐▌▐▌ ▐▌▐▌  █ ▐▌ ▐▌ █  ▐▌                              
▐▌▝▜▌▐▛▀▜▌ █  ▐▛▀▀▘▐▌ ▐▌▐▛▀▜▌ ▐▌      ▐▌ ▐▌▐▛▀▘ ▐▌  █ ▐▛▀▜▌ █  ▐▛▀▀▘                           
▝▚▄▞▘▐▌ ▐▌ █  ▐▙▄▄▖▐▙█▟▌▐▌ ▐▌ ▐▌      ▝▚▄▞▘▐▌   ▐▙▄▄▀ ▐▌ ▐▌ █  ▐▙▄▄▖                                                                                                                                                                                 
 "
    echo "=== Konfigurasi Gateway ==="
    echo -e "\033[1;32mVersi Firmware Saat Ini: $firmware_version\033[0m"
    echo "1. Konfigurasi Gateway Singapore"
    echo "2. Konfigurasi Gateway Indonesia"
    echo "3. Cek Informasi Sistem"
    echo "4. Upgrade Firmware"
    echo "5. Keluar"
    echo "================================"

    # Meminta input pilihan dari user
    read -p "Silakan pilih [1-5]: " choice

    # Menangani input user
    case "$choice" in
        1)
            edit_lora_files
            configure_singapore
            create_lorad_json_singapore
            set_dns_1_1_1_1
			setupstep2
            echo "Rebooting sistem..."
            reboot
            ;;
        2)
            edit_lora_files
            configure_indonesia
            create_lorad_json_indonesia
            set_dns_1_1_1_1
            echo "Rebooting sistem..."
            reboot
            ;;
        3)
            cek_system_info
            echo "Tekan Enter untuk kembali ke menu utama."
            read  # Menunggu user menekan Enter sebelum kembali ke menu
            main_menu  # Mengembalikan ke menu utama setelah menekan Enter
            ;;
        4)
            upgrade_firmware
            ;;
        5)
            echo "Keluar dari skrip. Sampai jumpa!"
            exit 0
            ;;
        *)
            echo "Pilihan tidak valid! Coba lagi."
            sleep 2
            main_menu
            ;;
    esac
}

# Main program
main_menu
