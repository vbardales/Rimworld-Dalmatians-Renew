---
mod:        Dalmatians Renew
packageId:  nelim.dalmatiansrenew
depot:      Rimworld-Dalmatians-Renew
visibilite: public
detache:    oui
etape:      done
licence:    silent
licence_ou: quatre endroits ; sorti du privé parce que mort et muet
vitrine:    complete
teste_le:
workshop:   
reste:
  - non_verifie: les treize scenarios de TESTING.md, aucun joue
  - non_verifie: C et D, le patch A Dog Said 2 et l'ordre de chargement, que rien hors jeu ne tranche
  - defaut: le cadavre dessiche n'a que sa texture _east, les deux autres faces sont des rotations
session:    local_e7fdeacc-7649-4702-9f00-45be2663ced1
maj:        2026-09-12, session du mod
---

# Dalmatians Renew — etat

Fiche d'etat, lue par une passe sur tous les mods plutot qu'en interrogeant les fils un a un.
Elle vit a la racine, jamais dans `Mod/`, donc Steam ne la recoit pas.

Les champs ci-dessus ont ete deduits du disque le 2026-09-12. Trois ne pouvaient pas l'etre et
attendaient la session qui tient ce mod. Ils ont ete renseignes le meme jour :

- **`etape`** — `done` confirme. Le port est entier : la wildness passee en stat, le patch A Dog
  Said reecrit sur les trois categories et garde par un `PatchOperationConditional`, le
  `loadBefore` declare, le francais a seize cles, les deux images refaites pour le port.
  `_tools/Run-Tests.ps1` passe, vingt-huit tests, aucun echec ni saut. Le depot est propre et
  `main` est pousse au meme commit qu'`origin`. Ce qui reste n'est pas du developpement : c'est la
  verification en jeu, puis la publication.
- **`teste_le`** — laisse vide, et c'est exact : ce dalmatien n'a jamais ete vu tourner. Aucun
  chien apprivoise, aucune carte d'information lue, aucun onglet operations ouvert.
- **`reste`** — la ligne posee d'office est remplacee par trois, maintenant que `TESTING.md` dit
  precisement ce qui n'a pas ete verifie. C et D sortent du lot parce qu'ils sont les seuls que
  rien hors jeu ne peut trancher : l'effet du patch vit dans une liste qu'A Dog Said 2 construit
  au chargement, et l'echec y est silencieux des deux cotes. La ligne `defaut` note le seul manque
  connu, herite de la source en 2018 et laisse tel quel — le corriger serait dessiner, pas porter.

Le champ `workshop` est vide parce que l'item n'existe pas encore : `About/PublishedFileId.txt` a
ete retire, il nommait celui de cucumpear et lavie2k.

Rappel des categories de `reste` : `feature` pour une fonctionnalite manquante au premier jet,
`defaut` pour un defaut connu non corrige, `non_verifie` pour ce qui n'a pas pu etre verifie.

Le champ `session` n'a pas ete touche : il vient du releve et designe le groupe de session, pas
cette conversation.

Vocabulaire de `licence` : `open` licence explicite, `silent` aucune licence et source morte,
`alive` aucune licence mais source vivante, `forbidden` refus ecrit, `original` rien de repris.
