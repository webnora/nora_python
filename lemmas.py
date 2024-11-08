class Lemmas:
  file_in  = 'd/unimorph/dict.txt'
  file_out = 'd/lemmas/dict.txt'
  file_unknown = 'd/in/dict.txt'

  def __init__(self, file = file_in, lemmas = None):
    self.lemmas = lemmas or self.load(file)
    self.file = file

  def save(self, file = file_out):
    print(f'save dict to: {file}')
    with open(file, 'w') as f:
      for lemma in sorted(self.lemmas.keys()):
        if lemma:
          for form in self.lemmas[lemma]:
            f.write(f'{lemma}\t{form}\n')
          f.write('\n')

  def load(self, file):
    lemmas = {}
    with open(file, 'r') as f:
      for lemma in f.read().split('\n\n'):
        forms = [l.split('\t') for l in lemma.split('\n')]
        key = forms[0][0]
        if key:
          lemmas[key] = [l[1] for l in forms if len(l) > 1]
    return lemmas

  def diff(self, file = file_unknown):
    lemmas = self.load(file)
    diff = set(self.lemmas.keys()) - set(lemmas.keys())
    print(f'new lemmas: {len(diff)} in {file}')

  def merge(self, file = file_unknown):
    lemmas = self.load(file)
    keys = {*set(self.lemmas.keys()), *set(lemmas.keys())}
    for lemma in keys:
      self.lemmas[lemma] = sorted({
        *set(lemmas.get(lemma, [])), 
        *set(self.lemmas.get(lemma, []))
        })

  def stat(self):
    print(f'lemmas: {len(self.lemmas.keys())} in {self.file}')

  def print(self, limit = 3):
    keys = list(self.lemmas.keys())
    for lemma in keys[:limit] + keys[-limit:]:
      print(f'{lemma}: {self.lemmas[lemma]}')


if __name__ == "__main__":
  l0 = Lemmas(Lemmas.file_unknown)
  l0.stat()

  l1 = Lemmas()
  l1.stat()
  l1.diff()
  l1.merge()
  l1.save()

  l2 = Lemmas(Lemmas.file_out)
  l2.stat()
  l2.print(1)