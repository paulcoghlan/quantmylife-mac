
import os, re, json
from util import *


def parseEventsFromStream(f):
  ms = 0
  try:
    while True:
      ms += uvarintRead(f)
      size = uvarintRead(f)
      payload = f.read(size)
      yield (ms, payload)
  except EOFError:
    pass


def signalDir(signalName):
  return os.path.expanduser(
      "~/Library/Application Support/QuantMyLife-dev/signals/%s" % signalName)


def readEvents(signalName):
  dirPath = signalDir(signalName)
  for filename in os.listdir(dirPath):
    if re.search(r'^\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}-\d{3}-Z\.v\d+$', filename):
      path = "%s/%s" % (dirPath, filename)
      with open(path, "rb") as f:
        for tup in parseEventsFromStream(f):
          yield tup


BECAME_ACTIVE = 1
BECAME_IDLE = 2

def input_idle():
  for ms, payload in readEvents('input-idle'):
    yield ms, 'input-idle', ord(payload)


def mouse_position():
  for ms, payload in readEvents('mouse-position'):
    x, y = uvarintsDecode(payload)
    yield ms, 'mouse-position', x, y

def front_app():
  for ms, payload in readEvents('front-app'):
    yield ms, 'front-app', json.loads(payload)


def front_thing():
  for ms, payload in readEvents('front-thing'):
    yield ms, 'front-thing', json.loads(payload)

def mojo_sampler():
  for ms, payload in readEvents('mojo-sampler'):
    x = uvarintDecode(payload)
    yield ms, 'mojo-sampler', x

def keyboard():
  for ms, payload in readEvents('keyboard'):
    yield ms, 'keyboard'



NAME_F_MAP = {
  'input-idle': input_idle,
  'mouse-position': mouse_position,
  'front-app': front_app,
  'front-thing': front_thing,
  'keyboard': keyboard,
  'mojo-sampler':mojo_sampler
}


def readPair(name1, name2):
  return mergeIteratorsOnFirstOfTuple(
            NAME_F_MAP[name1](),
            NAME_F_MAP[name2]())

