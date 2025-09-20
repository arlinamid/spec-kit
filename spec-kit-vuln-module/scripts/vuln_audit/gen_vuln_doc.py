#!/usr/bin/env python3
import argparse, yaml, datetime, pathlib, os

TEMPLATE = pathlib.Path(__file__).parent.parent.parent / "templates" / "vuln_audit" / "VULN_AUDIT_TEMPLATE.md"

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--meta", required=True)
    ap.add_argument("--out", required=True)
    args = ap.parse_args()

    meta = yaml.safe_load(open(args.meta, "r", encoding="utf-8"))
    subs = {
        "PROJECT_NAME": meta.get("name","Project"),
        "OWNER": meta.get("owner","Owner"),
        "REPO_URL": meta.get("repo_url",""),
        "DATE": datetime.date.today().isoformat(),
        "SYSTEM_OVERVIEW": meta.get("description",""),
        "DATA_CATEGORIES": ", ".join(meta.get("data_categories",[])),
        "ENVIRONMENTS": ", ".join(meta.get("environments",[])),
        "TECH_STACK": ", ".join(meta.get("languages",[])),
        "COMPONENTS": ", ".join(meta.get("threat_model_components",[])),
        "TRUST_BOUNDARIES": "TBD",
        "EXTERNALS": "TBD",
        "CODEQL_LANGS": ", ".join([l for l in meta.get("languages",[]) if l.lower() in {"python","cpp","csharp","java","javascript","typescript","go"}]) or "python",
    }

    tpl = open(TEMPLATE, "r", encoding="utf-8").read()
    # Simple ${KEY} replacement
    for k,v in subs.items():
        tpl = tpl.replace("${%s}" % k, str(v))

    outp = pathlib.Path(args.out)
    outp.write_text(tpl, encoding="utf-8")
    print(f"Wrote {outp}")

if __name__ == "__main__":
    main()
