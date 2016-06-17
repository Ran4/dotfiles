#!/usr/bin/env python3
import unittest

class MyTest(unittest.TestCase):
    def setUp(self):
        pass
    
    def tearDown(self):
        pass
    
    def test_something(self):
        self.fail("Please write tests!")
        
if __name__ == "__main__":
    unittest.main()
