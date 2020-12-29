# Roadmap

_see also [TODO](../todo.md), and Notes/ToDo/WorldCloud/apps.md_


## Arch ⩓

1. ISO has SSHD & Cloud Init

1. ISO can rebuild itself (and self-test, nested KVM) #dogfood


## Containers :whale:

1. ISO includes `runc` (`crun`?), `cri-o` and `kubelet` with self-test sample micro container baked into container.
   (We may not support pulling from "traditional" registry.)

1. ISO can build simple "hello, world" container using source `Dockerfile` and `FROM: scratch` (traditionally, "outside")

1. ISO has `sshd` shell container with fixed image (pubkey from Cloud Init)

1. ISO can build containers from within containers #dogfood
   Using [buildah](https://github.com/containers/buildah) & [kaniko](https://github.com/GoogleContainerTools/kaniko).

1. New containers can be started from within other containers
   Post or pre Kube? Pre, ideally. Declarative, not imperative!
   Use git repo pushed from within container to host, and actuated by systemd FS watch.

1. Run container from IPFS (simple v1; probably just `ipfs tar`)

1. [Buildpacks](https://buildpacks.io)

1. Shell container name/hash is dynamic instead of fixed, read from DID, and built on demand on the fly

1. Shell container can replace itself #dogfood #inception

1. ISO has read-only root filesystem

1. ISO has [gVisor](https://github.com/google/gvisor)


## CI, CD & CMS

1. Protocol (?) for obtaining any "content" (on IPFS) which was created by "transforming" a "source" (on IPFS).
   Static [HTML "CMS" for docs](https://docs.ipfs.io/how-to/websites-on-ipfs/static-site-generators/) or a container build
   are exactly the same thing.  Try to find it, and if it's not available in fixed time, it launches rebuilds on the fly.
   Must have a way to rebuild in fixed intervals. Probably somehow "pass through" arguments such Git tag version numbers?

1. Run container from source, given an URI like git and BuildPack, build on demand, if not already available cached on IPFS.

1. CMS like thing for self-hosting doc, starting with a MD to HTML transformation of this file? ;) #dogfood

1. Git web browser, simply implemented as above.


## IPFS 🧊 #storage

1. ISO has `ipfs` (systemd) _(and `/ipfs` & `/ipns` ?)_

1. Container proc can add content to nodes' IPFS
   Just forward daemon port into containers? Doc/demo.

1. Two ISO form an IPFS cluster together

1. Container proc can [pin on node](https://docs.ipfs.io/how-to/pin-files) and [in cluster](https://docs.ipfs.io/how-to/pin-files)
1. `ipfs mount` FUSE `/ipmfs` for `ipfs files` [Mutable File System (MFS)](https://docs.ipfs.io/concepts/file-systems/) #gap
   E.g. https://github.com/piedar/js-ipfs-mount or https://github.com/jfmherokiller/ipfs-mfs-fuse, done right.
   Note https://github.com/ipfs/notes/issues/131, also NFS idea on https://github.com/ipfs/roadmap/issues/83.

1. [Kubernetes Container Storage Interface](https://kubernetes-csi.github.io) (CSI) implementation on IPFS,
   idea also raised e.g. on https://discuss.ipfs.io/t/ipfs-as-a-storage-option-on-kubernetes/4506/2.

1. [IPFS Cluster](https://cluster.ipfs.io) supports "standard" [Pinning Service API Spec](https://github.com/ipfs/pinning-services-api-spec)
   instead of [it's own API](https://cluster.ipfs.io/documentation/reference/api/)
   and the [node local only API](https://docs.ipfs.io/how-to/pin-files)

1. Federated Pin API dispatcher service allows pinning in cluster and externally e.g. on Piñata et al.

1. Backup WIP files by pinning to IPFS cluster running at some friends

1. Create `ipfs/go-ds-blkdev` IPFS datastore directly backed by a Linux `/dev/` block device #performance #scale #efficiency.
   An alternative to https://github.com/ipfs?q=go-ds, notably the default https://github.com/ipfs/go-ds-flatfs
   implementation of https://github.com/ipfs/go-datastore.

1. [IPFS Git Remote Helper](https://www.google.com/search?q=ipfs+git+remote+helper),
   AND a corresponding server gateway ([`jgit`](https://www.eclipse.org/jgit/)?),
   like https://github.com/meyer1994/ipgit for ease of use.
   Either find a working one among the many attempts, or contribute to creating it on the most promising foundation.
   Note https://github.com/ipfs/roadmap/issues/43, and e.g. https://github.com/ipfs-shipyard/git-remote-ipld
   and https://github.com/whyrusleeping/git-ipfs-rehost, or https://github.com/cryptix/git-remote-ipfs,
   or https://developer.aliyun.com/mirror/npm/package/git-remote-ipfs-mam or https://github.com/dhappy/git-remote-ipfs
   or https://hackage.haskell.org/package/git-remote-ipfs, but see https://github.com/martindbp/ipvc#why-not-just-use-git
   for RW as RO like https://docs.ipfs.io/how-to/host-git-style-repo is obviously dumb.
   Git Browse Web UI is out of scope, here.

1. Encrypted IPFS blocks, as a separate overlay concept not baked into core, using DID.
   _Until this is available, this entire project is only suitable for public open code and content that is on the public web._
   This would, eventually, make a lot of sense for https://identity.foundation/working-groups/secure-data-storage.html...


## Identity 🆔

[Self-sovereign identity](https://en.wikipedia.org/wiki/Self-sovereign_identity).

1. `did:ipfs:` Decentralized Identifier (DID) for IPFS [Method Specification](https://identity.foundation/peer-did-method-spec/)
   and [Universal Resolver Driver](https://github.com/decentralized-identity/universal-resolver/blob/master/docs/driver-development.md).
   See https://identity.foundation, specifically https://identity.foundation/working-groups/identifiers-discovery.html
   and https://www.w3.org/TR/did-core/

1. Machine Identity is an IPFS DID.
   Either simply re-using IPFS PeerID, or have a separate key, but interlink them.

1. Shell container accepts anyone with a W3C DID, instead of requiring a pubkey from Cloud Init
   Works with any DID TBD from TBD, e.g. https://w3c-ccg.github.io/did-method-web/ or
   https://tools.ietf.org/html/draft-mayrhofer-did-dns-01 or
   https://github.com/decentralized-identity/github-did.

1. How to YubiKey <=> DID?

1. How to [WebAuthn](https://www.google.com/search?q=webauthn) <=> DID?

1. [Cloud Web Shell](https://github.com/vorburger/cloudshell), as above, but using WebAuthn instead of YubiKey

1. Research how to do Permissions/Grants/Privileges right?
   Not just black/white true/false, but with an economic model, for initial use cases:
   Pinned permanent storage space, and right to spawn new containers.


## Kube :wheel_of_dharma:

1. ISO can easily turn into a working basic Kube Node (with master & etcd)

1. Three ISO booted form a Kube cluster. Figure out auth.

1. [Ephemeral Volumes](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/) work out-of-the-box

1. Persistent volumes on IPFS? See above.

1. Log collections thing

1. Metrics thing


## Infra 🌐 :cloud: 🌌

1. Simple Kube Ingress tooling to serve IPFS content on custom DNS names,
   using https://docs.ipfs.io/how-to/address-ipfs-on-web or https://docs.ipfs.io/concepts/ipfs-gateway.

1. Classical DNS server which resolves to 🖧 LB IP of Kube Service on federated clusters.

1. `ssh term.dev` (TBD) gives anyone having a public key on any DID a shell (with limits)

1. abuse prevention for distributed shell, limit number of terms per DID, and rate limit per source IP? #DDOS #security

1. fully distributed decentralized builds


## Tools :hammer_and_wrench: :robot:

1. [Be](https://github.com/vorburger/b)? #be #build

1. Issues can be managed decentralized through simple files, distributed by Git.
   Bi-di import/export to GitHub, using e.g. https://github.com/MichaelMure/git-bug/ uel al?

1. Roadmap (this) is auto synchronized with GitHub Issues & Projects #plan #doc
   Basically a tool to transform this kind of file into the file structure of the previous item,
   plus [GitHub Projects](https://github.com/features/project-management/) support; add to `MichaelMure/git-bug`?

1. Roadmap (this) has a Tag Word Cloud image #doc
   The `##` project name section headers are just tags as well.

1. Automated weekly team status updates, pulled from systems like Git et al, pushed as text to a Git repo.
   E.g. https://github.com/psss/did or something like that.


## Apps 🏁

1. Messaging: Decentralized :mailbox_with_mail: "Email" and IM.
   Perhaps https://identity.foundation/working-groups/did-comm.html?


## Hardware

1. protoype custom ARM (and RISC V?) mini cluster boards

1. figure out sustainable economic model to "give out" boards for free ;)

1. see also https://github.com/ipfs/roadmap/issues/48


_[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/) This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/)._
