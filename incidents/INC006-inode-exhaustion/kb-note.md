# KB: "No Space Left on Device" While Disk Space Is Available

## Symptoms

- application cannot create files
- `touch` or application writes return `No space left on device`
- `df -h` still reports available disk capacity
- filesystem otherwise remains mounted and accessible

## Diagnostic Workflow

### 1. Check block usage

`df -h <mount-point>`

If significant space remains, do not assume storage capacity is healthy.

### 2. Check inode usage

`df -i <mount-point>`

100% inode utilization prevents creation of additional files or directories.

### 3. Identify filesystem

`findmnt <mount-point>`

### 4. Find high inode-consuming directories

`du --inodes -d 2 <mount-point>`

### 5. Count files where appropriate

`find <path> -xdev -type f | wc -l`

### 6. Identify the responsible workload

Determine whether cache files, temporary files, logs, session files, container data, or another application component is generating excessive filesystem objects.

## Key Principle

Filesystem capacity consists of more than data blocks.

A filesystem can have substantial free disk space while being unable to create files because all available inodes are exhausted.

`df -h` and `df -i` answer different questions.

## Resolution

Remove only confirmed obsolete files or correct the workload responsible for uncontrolled file creation.

Do not blindly delete files simply to recover inode capacity.

## Validation

Confirm:

- inode utilization falls below the exhaustion threshold
- normal block capacity remains healthy
- new file creation succeeds
- the file-generating workload is understood
