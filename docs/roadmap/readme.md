# Roadmap

_See also [what's done](done.md), as well as the [TODO](../todo.md) for a more "nitty gritty" level view._


## Arch ⩓ Kube :wheel_of_dharma:

1. first baremetal install - easy, now -- or is it, with x2 USB keys for Arch ISO & cloud-init; git clone and launch?

1. Something like `dinstall` from https://github.com/vorburger/LearningLinux/compare/WIP-arch-iso-dinstall
   to install from USB to persistent bare-metal. But test it in VM first.

1. Few `kubeadm join` Vagrant VMs, with different hostnames, on same subnet, form a working Kube cluster

1. [Cluster API-based](https://cluster-api.sigs.k8s.io) machine management, notably [CABPK](https://cluster-api.sigs.k8s.io/tasks/kubeadm-bootstrap.html)

1. Host & [Ephemeral Volumes](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/) work out-of-the-box

1. Service, LoadBalancer, Ingress.. how to expose on LAN and external public IP?!  VIIP? (HAProxy? [seesaw](https://github.com/google/seesaw)?)

1. trim down installed packages - it shouldn't have (need) `pacman` or most of `base` (IFF we can `pacstrap` without?)

1. make an AUR package of `kube-prepare.sh`, `kube-init.sh` (but why? ask on IRC releng if any real interest)

1. Security: installer partitions disk and puts `/bin` and `/usr` etc. into [SquashFS read-only filesystem](https://wiki.archlinux.org/index.php/File_systems#Read-only_file_systems),
   and mounts other BTRFS partitions [with `noexec` flag](https://man.archlinux.org/man/mount.8#FILESYSTEM-INDEPENDENT_MOUNT_OPTIONS)

1. [Certify it](https://www.cncf.io/certification/software-conformance/)? ;)


## Containers :whale:

1. [Learning Kubernetes CodeLabs ToDo](https://github.com/vorburger/LearningKubernetes-CodeLabs/blob/develop/TODO.md)

1. Flux https://toolkit.fluxcd.io/get-started/ (with [Kustomize](https://kustomize.io)?)
1. Metrics: Node Agent, cAdvisor, Prometheus, Grafana

1. [Logging](https://kubernetes.io/docs/concepts/cluster-administration/logging/)?!

1. `sshd` shell container with fixed image (pubkey from Cloud Init)
   sshd as systemd container https://docs.linuxserver.io/images/docker-openssh-server

1. New containers can be started from within other containers
   Post or pre Kube? Pre, ideally. Declarative, not imperative!
   Use git repo pushed from within container to host, and actuated by systemd.path.

1. ISO can build containers from within containers #dogfood
   Using [kaniko](https://github.com/GoogleContainerTools/kaniko) (not [buildah](https://github.com/containers/buildah))

1. Run container cached and distributed from IPFS cache, using https://github.com/miguelmota/ipdr.

1. Shell image name is read from DID (buildable by SCR)

1. Shell container can replace itself #dogfood #inception

1. kube auth

1. ISO has [gVisor](https://github.com/google/gvisor)


## CI, CD & CMS

1. [Skaffold](https://skaffold.dev)-, [Draft](https://draft.sh)- and/or [Garden](https://garden.io)-like (which?) dev model

1. Git server container:
   Initially simple/trivial, sshd with auth from cloud-init, like term, /data storage without IPFS yet,
   repo list configured in a YAML that is under Git itself, an "Operator" run by a Hook (or systemd.path?) actuates it
   (LATER ditto as Kube CRD); also see
   [old idea](https://github.com/vorburger/vorburger-dotfiles-bin-etc/tree/master/container/sshd).

1. [Source Container Registry](https://github.com/vorburger/SourceContainerRegistry) (SCR) which can build Images from Source.

1. Learn about [Buildpacks](https://buildpacks.io), [ArgoCD](https://argoproj.github.io/argo-cd/) and [TektonCD](https://tekton.dev)'s [Pipelines](https://github.com/tektoncd/pipeline/blob/main/docs/tutorial.md) relationship?

1. CMS like buildback for doc container images, starting with a MD to HTML transformation of this file? ;) #dogfood
   Basically a native [HTML "CMS" for static docs](https://docs.ipfs.io/how-to/websites-on-ipfs/static-site-generators/).

1. KISS static content shortcut, just a convention to have container images filled only with HTML (no web server `ENTRYPOINT`),
   plus [a `CNAME` file](https://github.com/lastnpe/lastnpe.github.io/blob/master/CNAME).  Then adding 1 line to `serving.yaml`,
   in some other Git repo, should suffice something (a "template operator"?) push that into IPFS (if it's not always already,
   as all container images will be?), and set up an ingress route to IPFS GW.

1. Maven repository, implemented simply using above

1. Git web browser, implemented simply as static site generator, as above.

1. _Generalize run image? Not just content, but any service, through some KISS shortcut, instead of YAML? (opt. from source, using SCR)_

1. Serve our ISO using above #dogfood

1. Container Registry Proxy: Proxies to other registry/-ies, ; stateless. #performance #scalability


## IPFS 🧊 #storage

1. ISO has `ipfs` (systemd) _(and `/ipfs` & `/ipns` ?)_

1. Container Registry on IPFS, with [IPDR](https://github.com/ipdr/ipdr)?

1. Container proc can add content to nodes' IPFS
   Just forward daemon port into containers? Doc/demo.

1. https://blog.ipfs.io

1. Two ISO form an IPFS cluster together

1. Container proc can [pin on node](https://docs.ipfs.io/how-to/pin-files) and [in cluster](https://docs.ipfs.io/how-to/pin-files)

1. `ipfs mount` FUSE `/ipmfs` for `ipfs files` [Mutable File System (MFS)](https://docs.ipfs.io/concepts/file-systems/) #gap, see https://github.com/ipfs/roadmap/issues/90. (One would expect this, and the `ipfs files` CLI, to have a way to support several "roots".) More like a [JGitFS](https://github.com/centic9/JGitFS)?

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
    AND a corresponding server gateway ([`jgit`](https://www.eclipse.org/jgit/), see [cookbook](https://github.com/centic9/jgit-cookbook)),
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

[Self-sovereign identity](https://en.wikipedia.org/wiki/Self-sovereign_identity) with [Decentralized Identifiers](https://www.w3.org/TR/did-core/) (DIDs).

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


## Security

1. Secure Boot, see https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot
   with https://man.archlinux.org/man/systemd-stub.7 ?

1. selinux/apparmor? (cri-o supported)


## Networking Opimizations

1. do not hard-code `8.8.8.8` for DNS anymore


## Hardware

1. [PC Engines APU2](https://pcengines.ch/apu2.htm), e.g. as (HAProxy? [seesaw](https://github.com/google/seesaw)?) LB/router!
   See [Arch Wiki](https://wiki.archlinux.org/index.php/PC_Engines),
   [this bug](https://gitlab.archlinux.org/archlinux/archiso/-/issues/75)
   and [their cheap prices](https://www.pcengines.ch/newshop.php?c=48881).

1. https://www.coreboot.org/users.html

1. protoype custom ARM (and RISC V?) mini cluster boards, e.g. [with Gumstix](https://www.gumstix.com)

1. figure out sustainable economic model to "give out" boards for free ;)

1. see also https://github.com/ipfs/roadmap/issues/48


_[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/) This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/)._


<!-- Do NOT use https://marktext.app to edit this nicely, because it keeps changing ordered list markers,
     see https://github.com/marktext/marktext/issues/2007; and other formatting like extra empty lines. -->
