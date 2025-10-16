import socket
import time
import random

# Server details
server_ip = '192.168.1.246'
server_port = 5062

# Create UDP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# Send 500 SIP INVITEs
for i in range(1010):
    call_id = f"{random.randint(100000, 999999)}{i}"
    from_tag = f"tag{i}{random.randint(1000,9999)}"
    branch = f"z9hG4bK{random.randint(100000,999999)}"

    message = (
        f"INVITE sip:500{i}@{server_ip}:{server_port} SIP/2.0\r\n"
        f"Via: SIP/2.0/UDP 192.168.1.100:5060;branch={branch}\r\n"
        f"From: <sip:caller@domain>;tag={from_tag}\r\n"
        f"To: <sip:callee@domain>\r\n"
        f"Call-ID: {call_id}\r\n"
        f"CSeq: 1 INVITE\r\n"
        f"Max-Forwards: 70\r\n"
        f"Contact: <sip:caller@192.168.1.100:5060>\r\n"
        f"Content-Length: 0\r\n"
        f"\r\n"
    )

    print(f"Sending INVITE {i} with tag={from_tag}, call-id={call_id}")
    sock.sendto(message.encode(), (server_ip, server_port))
    time.sleep(0.1)

sock.close()









# import socket
# import time

# # Server details
# server_ip = '192.168.1.246'
# server_port = 5062

# # Create UDP socket
# sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# # Send 500 SIP INVITEs
# for i in range(1002):
#     message = f"INVITE sip:500{i}@{server_ip}:{server_port} SIP/2.0\r\n"
#     message += "Via: SIP/2.0/UDP 192.168.1.100:5060;branch=z9hG4bK-12345\r\n"
#     message += "From: <sip:caller@domain>\r\n"
#     message += "To: <sip:callee@domain>\r\n"
#     message += "Call-ID: 123456789\r\n"
#     message += "CSeq: 1 INVITE\r\n"
#     message += "Max-Forwards: 70\r\n"
#     message += "\r\n"
    
#     sock.sendto(message.encode(), (server_ip, server_port))
#     time.sleep(0.1)  # 10 calls per second

# sock.close()
