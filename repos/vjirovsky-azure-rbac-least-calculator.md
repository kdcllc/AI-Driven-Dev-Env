# azure-rbac-least-calculator

- **URL:** https://github.com/vjirovsky/azure-rbac-least-calculator
- **Owner:** vjirovsky
- **Language:** JavaScript (React)
- **Stars:** —
- **Date Added:** 2026-04-20
- **Category:** Developer Tooling

## Summary

Azure RBAC Least Privilege Calculator is a browser-based tool that helps users identify the minimal Azure built-in RBAC role required to cover a given set of permissions. It fetches the full list of Azure built-in roles and their permissions daily from the Azure REST APIs, allowing users to select the permissions they need and immediately see which roles qualify. The tool also highlights gaps — permissions not covered by any built-in role — so users know when a custom role is necessary.

## Key Features

- Interactive UI for selecting one or more Azure permissions and filtering matching built-in roles
- Daily sync with Azure REST APIs to keep role and permission data current
- Highlights which permissions in a role definition match the requested set, and flags permissions unavailable in built-in roles
- Auto-generated shareable deep-links that encode the current permission selection for collaboration
- Static deployment via GitHub Pages (no backend required)

## Relevance to AI-Driven Development

When building agentic AI systems on Azure, assigning correctly scoped managed identities and service principals is essential for least-privilege security. This tool accelerates that workflow by surfacing the right built-in role instantly, reducing trial-and-error and keeping AI workloads compliant with the principle of least privilege.
