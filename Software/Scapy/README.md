# Scapy

- Resources: [official](https://scapy.net/), [unoffcial for beginners](https://theitgeekchronicles.files.wordpress.com/2012/05/scapyguide1.pdf)
- 

## Usage

### Stacking layers

- The `/` operator has been used as a composition operator between two layers. (The fields in the lower layer can be overloaded according to the upper layer). A string can used as a raw layers.

- ```shell
  >>> Ether()/IP()/IP()/UDP()
  <Ether type=0x800 |<IP frag=0 proto=IP |<IP frag=0 proto=UDP |<UDP |>>>>
  >>> a=Ether()/IP(dst="www.slashdot.org")/TCP()/"GET /index.html HTTP/1.0 \n\n"
  ```

- `_` denotes the latest shell results in the interactive mode.
  - When transformed from a raw string, the dissected packet will have all its fields filled. That’s because I consider that each field has its value imposed by the original string. If this is too verbose, the method `hide_defaults()` will delete every field that has the same value as the default.
- `ls(a)`: view values of all possible field