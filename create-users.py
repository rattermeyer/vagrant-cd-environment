#!/usr/bin/python
import gitlab

gl = gitlab.Gitlab('http://192.168.205.14:10080', 'zC5sgekDuRDeajMjszQy')
print(gl.users.list())
