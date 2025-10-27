This repository tracks the proposal for reorganizing [CSS docs on MDN](https://developer.mozilla.org/en-US/docs/Web/CSS).

## Folder structure (as JSON)

- Current CSS structure on MDN: [css-tree.json](https://github.com/dipikabh/mdn-css-reorg/blob/main/css-tree-proposed.json)
- Proposed CSS structure: [css-tree-proposed.json](https://github.com/dipikabh/mdn-css-reorg/blob/main/css-tree-proposed.json)


To view the folder structure as a JSON tree:
1. Download the `css-tree.json` and `css-tree-proposed.json` files.
2. To view them:
    - Open them in Firefox.
    - **_OR_** use [JSON Crack](https://jsoncrack.com/editor): File > Import, then View > Tree.

## Visual preview

This is a snapshot of the proposed structure (from JSONcrack):

<img width="348" alt="Screenshot from jsoncrack editor" src="https://github.com/user-attachments/assets/77c813b7-2d74-48af-8618-66bc5127f23c" />

---
#### How the JSON data was generated

To build a JSON tree of `files/en-us/web/css`, run this in the MDN repo root:

```bash
tree -L 3 -d -J files/en-us/web/css \
  | jq '
    def from_entries_recursive:
      map(select(.name != null))
      | map({
        key: .name,
        value: (if (.contents and (.contents | length > 0))
                then (.contents | from_entries_recursive)
                else {}
                end)
        })
      | from_entries;
    . | from_entries_recursive
  ' \
| pbcopy
```
