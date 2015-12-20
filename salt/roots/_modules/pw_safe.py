"""
Module to handle passwords for minion services like MySQL.
"""


from M2Crypto.Rand import rand_bytes
import logging, os, os.path, stat, errno, re, crypt

log = logging.getLogger(__name__)


DEFAULT_ALPHABET = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890"
BASE64_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
CRYPT_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789./"
BASE_PATH = '/etc/salt/pw_safe'
# BASE_PATH = '/Users/dj/.pw_safe'

def _mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as exc: # Python >2.5
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else: raise

def _safe_path_fragment(path):
  return re.sub(r'^\.+','', re.sub(r'[^a-zA-Z0-9_.-]', '', path))

def _pw_file_name(key):
  path_fragment = _safe_path_fragment(key)
  if not key:
    raise NameError('%s is no valid key'%key)
  _mkdir_p(BASE_PATH)
  os.chmod(BASE_PATH, stat.S_IRUSR | stat.S_IWUSR | stat.S_IXUSR)
  file_name = os.path.join(BASE_PATH, path_fragment)
  open(file_name, 'a')
  os.chmod(file_name, stat.S_IRUSR | stat.S_IWUSR | stat.S_IXUSR)
  return file_name

def random(length = 20, alphabet = DEFAULT_ALPHABET, veto_chars = None):
  if veto_chars:
    alphabet = re.sub('[%s]'%veto_chars, '', alphabet)
  if len(alphabet) < 16:
    raise ArgumentError('size of alphabet cannot be smaller than 16 characters')
  bytes = rand_bytes(length)
  password = ""
  for byte in bytes:
    password += alphabet[ ord(byte) % len(alphabet)]
  return password

def get(key, random_if_empty=True, random_length = 20, random_alphabet = DEFAULT_ALPHABET, random_veto_chars = None):
  file_name = _pw_file_name(key)
  pw = open(file_name, 'rb').read()
  if not pw and random_if_empty:
    pw = random(random_length, random_alphabet, random_veto_chars)
    set(key, pw)
  return pw

def get_mysql_user_password(username):
  return get('mysql.%s'%username, random_veto_chars="'\"#;/") # no characters that would break the SQL statement or /root/.my.cnf

def set(key, password):
  file_name = _pw_file_name(key)
  open(file_name, 'wb').write(password)
  return True

def get_unix_crypt(salt_key, password):
  crypt_salt = '$6$%s$' % get('salt.'+salt_key, random_length=8, random_alphabet = CRYPT_ALPHABET)
  return crypt.crypt(password, crypt_salt)

if __name__ == '__main__':
  print random(30, veto_chars = ';')
  print _safe_path_fragment("../../../ev il.txt////")
  print get('bluber', random_veto_chars=';')
