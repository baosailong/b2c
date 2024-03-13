from flask import Flask, request, jsonify
import pymysql
from flask_cors import CORS
import rsa
from rsa.key import PrivateKey,PublicKey
import random
import pandas as pd
from flask import send_file
app = Flask(__name__)
app.config.from_object(__name__)
CORS(app, resources={r'/*': {'origins': '*'}}, supports_credentials=True)
globaluseraccount="%"
def rsa_key_to_pem(key):
    pem = key.save_pkcs1().decode()
    return pem
def pem_to_rsa_key_pri(pem):
    rsa_key = PrivateKey.load_pkcs1(pem.encode())
    return rsa_key
def get_db():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='bsl20030503',
        database='b2c'
    )
@app.route('/')
def hello():
    return 'Hello, Flask!'
# 注册路由
# 输入:账户 密码 用户名 用户类型
@app.route('/register', methods=['POST'])
def register():
    # 获取注册信息
    account = request.json.get('account')
    password = request.json.get('password')
    username = request.json.get('username')
    usertype = request.json.get('usertype')
    print(account,password,username,usertype)
    if not all([account, password, username, usertype]):
        return jsonify({'error': 'Missing registration information'}), 400
    
    # 判重
    try:
        #产生密钥和公钥
        (publickey,privatekey)=rsa.newkeys(2048)
        privatepem=privatekey.save_pkcs1().decode()
        publicpem=publickey.save_pkcs1().decode()
        conn = get_db()
        with conn.cursor() as cursor:
            cursor.execute('SELECT * FROM users WHERE account = %s', (account))
            existing_user = cursor.fetchone()
        if existing_user:
            return jsonify({'error': 'Account already exists'}), 400
        
        # 保存用户信息到数据库
        with conn.cursor() as cursor:
            cursor.execute(
                'INSERT INTO users (account, password, username, usertype) VALUES (%s, %s, %s, %s)',
                (account, password, username, usertype)
            )
            cursor.execute(
                'INSERT INTO miyao (account, privatekey,publickey) VALUES (%s, %s, %s)',
                (account, privatepem,publicpem)
            )
        conn.commit()
        return jsonify({'message': 'Registration successful'})
    except pymysql.Error as e:
        print("Error",e)
        return jsonify({'error': 'Registration failed: {}'.format(str(e))}), 500
@app.route('/login',methods=['post'])
def login():
    global globaluseraccount
    account = request.json.get('account')
    password = request.json.get('password')
    print(account,password)
    try:
        #判存在
        conn = get_db()
        with conn.cursor() as cursor:
            cursor.execute('SELECT * FROM users WHERE account = %s', (account,))
            existing_user = cursor.fetchone()
        
        if not existing_user:
            return jsonify({'error': 'Invalid account or password'}), 401
        #解密
        with conn.cursor() as cursor:
            cursor.execute('SELECT privatekey FROM miyao WHERE account = %s', (account,))
            private_pem = cursor.fetchone()[0]
            rsa_key = rsa.PrivateKey.load_pkcs1(private_pem)
            
        #解密密码
        passwordbytes=password.encode('utf-8')
        print(passwordbytes)
        decrypted_password = request.json.get('password')
        stored_password = existing_user[1]
        if decrypted_password != stored_password:
            return jsonify({'error': 'Invalid account or password'}), 401
        # 登录成功，可以进行进一步的操作
        globaluseraccount=account
        return jsonify({'message': 'Login successful'})
    except pymysql.Error as e:
        print(e)
        return jsonify({'error': 'Login failed: {}'.format(str(e))}), 500
@app.route('/getPublicKey',methods=['post'])
def getPublicKey():
    account = request.json.get('account')
    try:
        conn = get_db()
        #查询
        with conn.cursor() as cursor:
            cursor.execute('SELECT publickey FROM miyao WHERE account = %s', (account,))
            public_key = cursor.fetchone()[0]
        if not public_key:
            return jsonify({'error': 'Invalid account or password'}), 401
        print(public_key)
        return jsonify({'publicKey': public_key})
    except pymysql.Error as e:
        print(e)
        return jsonify({'error': 'query failed'}), 500
@app.route('/getUserAccount',methods=['post'])
def getUserAccount():
    global globaluseraccount
    print(globaluseraccount)
    if globaluseraccount =='%':
        return jsonify({'account':'%','usertype':'1'})
    conn = get_db()
    try:
        with conn.cursor() as cursor:
            cursor.execute('SELECT usertype FROM users WHERE account=%s',(globaluseraccount,))
            usertype=cursor.fetchone()[0]
            cursor.execute('SELECT username FROM users WHERE account=%s',(globaluseraccount,))
            username=cursor.fetchone()[0]
            cursor.execute('SELECT publickey from miyao WHERE account=%s',(globaluseraccount,))
            publickey=cursor.fetchone()[0]
    except pymysql.Error as e:
        print(e)
        return jsonify({'account':'%','usertype':'1'})
    return jsonify({'account':globaluseraccount,'usertype':usertype,'username':username,'publickey':publickey})
@app.route('/getGoods',methods=['post'])
def getGoods():
    try:
        conn = get_db()
        #查询
        goods=[]
        with conn.cursor() as cursor:
            cursor.execute('SELECT * FROM goods')
            rows =cursor.fetchall()
            for row in rows:
                goods.append({
                    'name':row[0],
                    'id':row[1],
                    'description':row[2],
                    'price':row[3],
                    'account':row[4]
                })
        return jsonify({'goods': goods})
    except pymysql.Error as e:
        print(e)
        return jsonify({'error': 'query failed'}), 500
@app.route('/getallusers',methods=['post'])
def getallusers():
    try:
        conn = get_db()
        #查询
        users=[]
        with conn.cursor() as cursor:
            cursor.execute('SELECT * FROM users')
            rows =cursor.fetchall()
            for row in rows:
                users.append({
                    'account':row[0],
                    'name':row[2],
                    'type':row[3],
                })
        return jsonify({'users': users})
    except pymysql.Error as e:
        print(e)
        return jsonify({'error': 'query failed'}), 500
@app.route('/deleteuser',methods=['post'])
def deleteuser():
    account=request.json.get('account')
    print(account)
    try:
        conn = get_db()
        #查询
        with conn.cursor() as cursor:
            cursor.execute('delete FROM users WHERE account=%s',(account))
            cursor.execute('delete FROM goods WHERE account=%s',(account))
            cursor.execute('delete FROM miyao WHERE account=%s',(account))
            cursor.execute('delete FROM cart WHERE account=%s',(account))
        conn.commit()
        return jsonify({'message':'succeed'})
    except pymysql.Error as e:
        print(e)
        return jsonify({'error': 'query failed'}), 500
@app.route('/buy',methods=['post'])
def buy():
    name = request.json.get('name')
    price = request.json.get('price')
    global globaluseraccount
    try:
        conn=get_db()
        # 加入物品信息到数据库
        with conn.cursor() as cursor:
            cursor.execute(
                'INSERT INTO cart (account,name,price) VALUES (%s, %s, %s)',
                (globaluseraccount,name,price)
            )
        conn.commit()
        return jsonify({'message': 'Registration successful'})
    except pymysql.Error as e:
        print("Error",e)
        return jsonify({'error': 'Registration failed: {}'.format(str(e))}), 500
@app.route('/submit',methods=['post'])
def submit():
    name = request.json.get('name')
    price = request.json.get('price')
    description = request.json.get('description')
    global globaluseraccount
    id=random.randint(1,10000)
    try:
        conn=get_db()
        # 加入物品信息到数据库
        with conn.cursor() as cursor:
            cursor.execute(
                'INSERT INTO goods (name,id,description,price,account) VALUES (%s, %s, %s,%s,%s)',
                (name,id,description,price,globaluseraccount)
            )
        conn.commit()
        return jsonify({'message': 'commit successful'})
    except pymysql.Error as e:
        print("Error",e)
        return jsonify({'error': 'Registration failed: {}'.format(str(e))}), 500
@app.route('/getcart',methods=['post'])
def getcart():
    global globaluseraccount
    try:
        conn = get_db()
        #查询
        cart=[]
        totprice=0
        with conn.cursor() as cursor:
            cursor.execute('SELECT * FROM cart WHERE account=%s',globaluseraccount)
            rows =cursor.fetchall()
            for row in rows:
                cart.append({
                    'name':row[1],
                    'price':row[2]
                })
                totprice+=row[2]
        return jsonify({'cart': cart,'count':len(cart),'totprice':totprice})
    except pymysql.Error as e:
        print(e)
        return jsonify({'error': 'query failed'}), 500
@app.route('/pay',methods=['post'])
def pay():
    global globaluseraccount
    address = request.json.get('address')
    password = request.json.get('password')
    items = request.json.get('items')
    try:
        #判存在
        conn = get_db()
        with conn.cursor() as cursor:
            cursor.execute('SELECT * FROM users WHERE account = %s', (globaluseraccount,))
            existing_user = cursor.fetchone()
        stored_password = existing_user[1]
        if password != stored_password:
            return jsonify({'error': 'Invalid account or password'}), 401
        with conn.cursor() as cursor:
            cursor.execute('delete FROM cart WHERE account = %s',(globaluseraccount))
        conn.commit()
        #创建订单
        print(items)
        for item in items:
            name=item['name']
            with conn.cursor() as cursor:
                cursor.execute('SELECT account FROM goods where name=%s',(name))
                seller=cursor.fetchone()[0]
            with conn.cursor() as cursor:
                nowaddr="未知"
                done='0'
                cursor.execute(
                    'INSERT INTO logistics (address,seller,nowaddr,buyer,name,done) VALUES(%s,%s,%s,%s,%s,%s)',
                    (address,seller,nowaddr,globaluseraccount,name,done)
            )
        conn.commit()
        return jsonify({'message': 'Login successful'})
    except pymysql.Error as e:
        print(e)
        return jsonify({'error': 'Login failed: {}'.format(str(e))}), 500
@app.route('/deleteitem',methods=['post'])
def deleteitem():
    item = request.json.get('item')
    name = item['name']
    global globaluseraccount
    try:
        conn = get_db()
        with conn.cursor() as cursor:
            cursor.execute('delete FROM cart WHERE name=%s AND account=%s',(name,globaluseraccount))
        conn.commit()
        return jsonify({'message':'succeed'})
    except pymysql.Error as e:
        print(e)
        return jsonify({'error': 'query failed'}), 500
@app.route('/update',methods=['post'])
def update():
    updateaddr=request.json.get('updateaddr')
    isdone=request.json.get('isdone')
    info =request.json.get('info')
    print(info)
    name=info['name']
    address=info['address']
    if(isdone == 1):
        try:
            conn = get_db()
            #更新
            with conn.cursor() as cursor:
                cursor.execute('UPDATE logistics SET done=1 WHERE name=%s AND address=%s',(name,address))
                cursor.execute('UPDATE logistics SET nowaddr=%s WHERE name=%s AND address=%s',(updateaddr,name,address))
            conn.commit()
            return jsonify({'message':'succeed'})
        except pymysql.Error as e:
            print(e)
            return jsonify({'error': 'query failed'}), 500
@app.route('/getallinfo',methods=['post'])
def getallinfo():
    send=[]
    receive=[]
    global globaluseraccount
    try:
        conn = get_db()
        with conn.cursor() as cursor:
            cursor.execute('SELECT * FROM logistics WHERE seller=%s',(globaluseraccount))
            rows =cursor.fetchall()
            for row in rows:
                send.append({
                    'address':row[0],
                    'name':row[4],
                    'done':row[5],
                    'nowaddr':row[2]
                })
            cursor.execute('SELECT * FROM logistics WHERE buyer=%s',(globaluseraccount))
            rows =cursor.fetchall()
            for row in rows:
                receive.append({
                    'address':row[0],
                    'name':row[4],
                    'done':row[5],
                    'nowaddr':row[2]
                })
        return jsonify({'send': send,'receive':receive})
    except pymysql.Error as e:
        print(e)
        return jsonify({'error': 'query failed'}), 500
@app.route('/getorders',methods=['post'])
def getorders():
    # orders:[{
    #           address:"test",
    #           seller:"seller",
    #           nowaddr:"nowaddr",
    #           done:"0",
    #           buyer:"buyer",
    #           name:"name"
    #         }],
    try:
        orders=[]
        conn = get_db()
        with conn.cursor() as cursor:
            cursor.execute('SELECT * FROM logistics')
            rows =cursor.fetchall()
            for row in rows:
                orders.append({
                    'address':row[0],
                    'seller':row[1],
                    'buyer':row[3],
                    'name':row[4],
                    'done':row[5],
                    'nowaddr':row[2]
                })
        return jsonify({'orders':orders})
    except pymysql.Error as e:
        print(e)
        return jsonify({'error': 'query failed'}), 500
@app.route('/outexcel',methods=['post'])
def outexcel():
    # orders:[{
    #           address:"test",
    #           seller:"seller",
    #           nowaddr:"nowaddr",
    #           done:"0",
    #           buyer:"buyer",
    #           name:"name"
    #         }],
    try:
        orders=[]
        conn = get_db()
        with conn.cursor() as cursor:
            cursor.execute('SELECT * FROM logistics')
            rows =cursor.fetchall()
            for row in rows:
                orders.append({
                    'address':row[0],
                    'seller':row[1],
                    'buyer':row[3],
                    'name':row[4],
                    'done':row[5],
                    'nowaddr':row[2]
                })
        df = pd.DataFrame(orders)
        df.to_excel('orders.xlsx', index=False)
        filename = 'orders.xlsx'
        # 发送文件给前端进行下载
        return send_file(
            filename,
            as_attachment=True,
            attachment_filename=filename
        )
    except pymysql.Error as e:
        print(e)
        return jsonify({'error': 'query failed'}), 500
if __name__ == '__main__':
    app.run()