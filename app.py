from flask import Flask, render_template, request, make_response
from redis import Redis
import os
import socket
import random
import json

option_a = os.getenv('OPTION_A', "Cats")
option_b = os.getenv('OPTION_B', "Birds")
hostname = socket.gethostname()


class AppWrapper:

    def __init__(self, name, redis):
        self.app = Flask(name)
        self.redis = redis
        self.setup_home_route()

    def run(self, **options):
        self.app.run(**options)

    def setup_home_route(self):
        self.app.add_url_rule('/', 'hello', self.hello, methods = ['GET', 'POST'])

    def hello(self):
        voter_id = request.cookies.get('voter_id')
        if not voter_id:
            voter_id = hex(random.getrandbits(64))[2:-1]

        vote = None

        if request.method == 'POST':
            vote = request.form['vote']
            self.push_vote_to_redis(voter_id, vote)

        resp = make_response(render_template(
            'index.html',
            option_a=option_a,
            option_b=option_b,
            hostname=hostname,
            vote=vote,
        ))
        resp.set_cookie('voter_id', voter_id)
        return resp

    def push_vote_to_redis(self, voter_id, vote):
        data = json.dumps({'voter_id': voter_id, 'vote': vote})
        return self.redis.rpush('votes', data)


redis = Redis(host="redis", db=0, socket_timeout=5)
app_wrapper = AppWrapper(__name__, redis)

# setting this up for gunicorn
app = app_wrapper.app

if __name__ == "__main__":
    app_wrapper.run(host='0.0.0.0', port=80, debug=True, threaded=True)
