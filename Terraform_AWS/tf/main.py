import sys
import json 
import configparser
from sizing import getsizing,buildinstancemap

data = {
    'name': 'kiran',
    'keypair': 'kirankey',
    'size' : 't2.xlarge',
    'volumesize' : 100,
    'instancecount' : 5
} 

def write2file(file,data):
    with open(file,'w')  as fl:
        fl.write(data)

def main():
    instancemap=buildinstancemap('instance_type.properties')
    basedir = sys.argv[1]
    sizing = getsizing(instancemap,'m5.xlarge',10,24)
    instancetype = list(sizing.keys())[0]
    instancecount = sizing[instancetype]['count']
    data['size'] = instancetype
    data['instancecount'] = instancecount
    print('Generating terraform.tfvars')
    tfvars = ""
    for k,v in data.items():
        tfvars+="{} = \"{}\"\n".format(k,v)
    write2file('{}/terraform.tfvars'.format(basedir),tfvars)
    print('terraform.tfvars Generated')

if __name__ == '__main__':
    main()