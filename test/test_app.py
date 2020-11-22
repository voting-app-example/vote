from app import AppWrapper
from unittest import TestCase, mock

class TestApp(TestCase):

    def setUp(self):
        self.redis = mock.Mock()
        self.redis.rpush.return_value = 1

    def test_vote_pushed_to_redis(self):
        app = AppWrapper('', self.redis)
        dummy_voter_id = '1'
        dummy_vote = 'CATS'
        result = app.push_vote_to_redis(dummy_voter_id, dummy_vote)
        self.assertEqual(result, 1)