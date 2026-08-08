from pathlib import Path
from sys import stdin
from match_client.match import Match
from match_client.match.ttypes import User

from thrift import Thrift
from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol

user_id=0
username='unlastingstar'
output_file=''
num=0
def operate(op):
    global user_id
    global username
    global output_file
    global num
    # Make socket
    transport = TSocket.TSocket('localhost', 9090)

    # Buffering is critical. Raw sockets are very slow
    transport = TTransport.TBufferedTransport(transport)

    # Wrap in a protocol
    protocol = TBinaryProtocol.TBinaryProtocol(transport)

    # Create a client to use the protocol encoder
    client = Match.Client(protocol)

    # Connect!
    transport.open()
    #print(user_id,username,output_file,num)
    if op == "add":
        user=User(user_id,username)
        client.add_user(user,"")
    elif op=="remove" :
        user=User(user_id,username)
        client.remove_user(user,"")
    elif op=="list" :
        client.list_user(output_file,"")
    elif op=="rand":
        client.get_random(num,output_file,"")

    # Close!
    transport.close()

def main():
    global user_id
    global username
    global output_file
    global num
    pos=''
    while pos!="y" and pos!="n":
        pos=input("Do you want to input command in the file ? [y/n]\n")
    if pos=='y':    
        path=Path("..//..//order.txt")
        contents=path.read_text()
        lines = contents.splitlines()
        pi_string=''
        for line in lines:
        #for line in stdin:
            m_content=line.split()
            opt=m_content[0]
            #print(m_content)
            if opt=="add" or opt=="remove":
                user_id=int(m_content[1])
                username=m_content[2]
            elif opt=="list":
                output_file=m_content[1]
            elif opt=="rand":
                num=int(m_content[1])
                output_file=m_content[2]
            else :
                continue
            operate(opt)
    elif pos=='n':    
        '''path=Path("..//..//order.txt")
        contents=path.read_text()
        lines = contents.splitlines()
        pi_string=''
        for line in lines:'''
        for line in stdin:
            m_content=line.split()
            opt=m_content[0]
            #print(m_content)
            if opt=="add" or opt=="remove":
                user_id=int(m_content[1])
                username=m_content[2]
            elif opt=="list":
                output_file=m_content[1]
            elif opt=="rand":
                num=int(m_content[1])
                output_file=m_content[2]
            else :
                continue
            operate(opt)
if __name__ == "__main__" :
    main()
