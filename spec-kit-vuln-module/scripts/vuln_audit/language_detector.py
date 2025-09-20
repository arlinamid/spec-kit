#!/usr/bin/env python3
"""
Language Detection System for Multi-Language Security Auditing
Automatically detects programming languages in a project and configures appropriate security tools.
"""

import os
import json
import yaml
from pathlib import Path
from typing import Dict, List, Set, Optional
import subprocess
import sys

class LanguageDetector:
    """Detects programming languages and their security scanning requirements."""
    
    # Language detection patterns
    LANGUAGE_PATTERNS = {
        'python': {
            'files': ['*.py', '*.pyi', '*.pyc', '*.pyo'],
            'manifests': ['requirements.txt', 'pyproject.toml', 'setup.py', 'Pipfile', 'poetry.lock'],
            'dirs': ['__pycache__', '.venv', 'venv', 'env'],
            'tools': ['bandit', 'pip-audit', 'safety', 'semgrep']
        },
        'javascript': {
            'files': ['*.js', '*.mjs', '*.cjs'],
            'manifests': ['package.json', 'yarn.lock', 'package-lock.json'],
            'dirs': ['node_modules', '.next', 'dist', 'build'],
            'tools': ['npm-audit', 'yarn-audit', 'semgrep', 'eslint-plugin-security']
        },
        'typescript': {
            'files': ['*.ts', '*.tsx', '*.d.ts'],
            'manifests': ['package.json', 'tsconfig.json', 'yarn.lock', 'package-lock.json'],
            'dirs': ['node_modules', '.next', 'dist', 'build', 'lib'],
            'tools': ['npm-audit', 'yarn-audit', 'semgrep', 'eslint-plugin-security', 'tslint-security']
        },
        'go': {
            'files': ['*.go'],
            'manifests': ['go.mod', 'go.sum', 'Gopkg.toml', 'Gopkg.lock'],
            'dirs': ['vendor', 'pkg'],
            'tools': ['gosec', 'golangci-lint', 'semgrep', 'govulncheck']
        },
        'rust': {
            'files': ['*.rs', '*.toml'],
            'manifests': ['Cargo.toml', 'Cargo.lock'],
            'dirs': ['target', '.cargo'],
            'tools': ['cargo-audit', 'cargo-deny', 'semgrep', 'clippy']
        },
        'java': {
            'files': ['*.java', '*.jsp', '*.jspx'],
            'manifests': ['pom.xml', 'build.gradle', 'build.gradle.kts', 'gradle.properties'],
            'dirs': ['target', 'build', 'out', '.gradle'],
            'tools': ['spotbugs', 'checkmarx', 'semgrep', 'owasp-dependency-check']
        },
        'csharp': {
            'files': ['*.cs', '*.csproj', '*.sln'],
            'manifests': ['*.csproj', '*.sln', 'packages.config', 'project.json'],
            'dirs': ['bin', 'obj', 'packages'],
            'tools': ['security-code-scan', 'semgrep', 'sonarqube']
        },
        'cpp': {
            'files': ['*.cpp', '*.cc', '*.cxx', '*.c++', '*.hpp', '*.h'],
            'manifests': ['CMakeLists.txt', 'Makefile', '*.cmake'],
            'dirs': ['build', 'cmake-build-debug', 'cmake-build-release'],
            'tools': ['cppcheck', 'clang-tidy', 'semgrep', 'flawfinder']
        },
        'c': {
            'files': ['*.c', '*.h'],
            'manifests': ['Makefile', 'CMakeLists.txt', '*.cmake'],
            'dirs': ['build', 'cmake-build-debug', 'cmake-build-release'],
            'tools': ['cppcheck', 'clang-tidy', 'semgrep', 'flawfinder']
        },
        'php': {
            'files': ['*.php', '*.phtml'],
            'manifests': ['composer.json', 'composer.lock'],
            'dirs': ['vendor', 'node_modules'],
            'tools': ['phpcs-security-audit', 'semgrep', 'psalm']
        },
        'ruby': {
            'files': ['*.rb', '*.rake'],
            'manifests': ['Gemfile', 'Gemfile.lock', 'Rakefile'],
            'dirs': ['vendor', 'bundle'],
            'tools': ['brakeman', 'bundler-audit', 'semgrep', 'rubocop']
        },
        'swift': {
            'files': ['*.swift'],
            'manifests': ['Package.swift', 'Podfile', 'Podfile.lock'],
            'dirs': ['Pods', '.build'],
            'tools': ['swiftlint', 'semgrep', 'xcodebuild']
        },
        'kotlin': {
            'files': ['*.kt', '*.kts'],
            'manifests': ['build.gradle', 'build.gradle.kts', 'pom.xml'],
            'dirs': ['build', 'out'],
            'tools': ['detekt', 'semgrep', 'spotbugs']
        },
        'scala': {
            'files': ['*.scala', '*.sbt'],
            'manifests': ['build.sbt', 'pom.xml'],
            'dirs': ['target', 'project'],
            'tools': ['sbt-dependency-check', 'semgrep', 'scalastyle']
        },
        'dart': {
            'files': ['*.dart'],
            'manifests': ['pubspec.yaml', 'pubspec.lock'],
            'dirs': ['.dart_tool', 'build'],
            'tools': ['dart-analyzer', 'semgrep', 'flutter-analyze']
        },
        'shell': {
            'files': ['*.sh', '*.bash', '*.zsh', '*.fish'],
            'manifests': [],
            'dirs': [],
            'tools': ['shellcheck', 'semgrep', 'shfmt']
        },
        'powershell': {
            'files': ['*.ps1', '*.psm1', '*.psd1'],
            'manifests': [],
            'dirs': [],
            'tools': ['psscriptanalyzer', 'semgrep', 'powershell-analyzer']
        },
        'yaml': {
            'files': ['*.yml', '*.yaml'],
            'manifests': [],
            'dirs': [],
            'tools': ['yamllint', 'semgrep', 'kube-score']
        },
        'dockerfile': {
            'files': ['Dockerfile*', '*.dockerfile', 'docker-compose.yml'],
            'manifests': [],
            'dirs': [],
            'tools': ['hadolint', 'trivy', 'semgrep', 'dockerfile-lint']
        }
    }
    
    def __init__(self, project_root: str = "."):
        self.project_root = Path(project_root)
        self.detected_languages: Set[str] = set()
        self.language_files: Dict[str, List[Path]] = {}
        self.manifest_files: Dict[str, List[Path]] = {}
        
    def detect_languages(self) -> Dict[str, any]:
        """Detect all programming languages in the project."""
        print("🔍 Detecting programming languages...")
        
        for lang, config in self.LANGUAGE_PATTERNS.items():
            if self._detect_language(lang, config):
                self.detected_languages.add(lang)
                print(f"  ✅ {lang.upper()}")
            else:
                print(f"  ❌ {lang.upper()}")
        
        return {
            'languages': list(self.detected_languages),
            'language_files': {lang: [str(f) for f in files] for lang, files in self.language_files.items()},
            'manifest_files': {lang: [str(f) for f in files] for lang, files in self.manifest_files.items()},
            'tools': self._get_required_tools()
        }
    
    def _detect_language(self, lang: str, config: Dict) -> bool:
        """Detect if a specific language is present in the project."""
        found_files = []
        found_manifests = []
        
        # Check for language-specific files
        for pattern in config['files']:
            files = list(self.project_root.rglob(pattern))
            if files:
                found_files.extend(files)
        
        # Check for manifest files
        for manifest in config['manifests']:
            manifest_path = self.project_root / manifest
            if manifest_path.exists():
                found_manifests.append(manifest_path)
            else:
                # Also check for glob patterns
                for path in self.project_root.rglob(manifest):
                    found_manifests.append(path)
        
        # Check for language-specific directories
        for dir_pattern in config['dirs']:
            if any(self.project_root.rglob(dir_pattern)):
                found_files.append(Path(dir_pattern))
        
        if found_files or found_manifests:
            self.language_files[lang] = found_files
            self.manifest_files[lang] = found_manifests
            return True
        
        return False
    
    def _get_required_tools(self) -> Dict[str, List[str]]:
        """Get required security tools for detected languages."""
        tools = {}
        for lang in self.detected_languages:
            if lang in self.LANGUAGE_PATTERNS:
                tools[lang] = self.LANGUAGE_PATTERNS[lang]['tools']
        return tools
    
    def generate_scan_config(self) -> Dict:
        """Generate configuration for multi-language scanning."""
        detection_result = self.detect_languages()
        
        config = {
            'project_info': {
                'languages_detected': detection_result['languages'],
                'total_languages': len(detection_result['languages']),
                'detection_timestamp': str(Path().cwd())
            },
            'scanning_strategy': {
                'universal_tools': ['semgrep', 'trivy', 'gitleaks', 'syft'],
                'language_specific_tools': detection_result['tools'],
                'priority_order': self._get_scan_priority()
            },
            'language_details': detection_result
        }
        
        return config
    
    def _get_scan_priority(self) -> List[str]:
        """Get scanning priority based on language prevalence and security risk."""
        priority_map = {
            'python': 1,
            'javascript': 2,
            'typescript': 2,
            'java': 3,
            'go': 4,
            'rust': 4,
            'csharp': 3,
            'cpp': 5,
            'c': 5,
            'php': 6,
            'ruby': 6,
            'swift': 7,
            'kotlin': 7,
            'scala': 8,
            'dart': 8,
            'shell': 9,
            'powershell': 9,
            'yaml': 10,
            'dockerfile': 11
        }
        
        # Sort detected languages by priority
        sorted_langs = sorted(
            self.detected_languages,
            key=lambda x: priority_map.get(x, 999)
        )
        
        return sorted_langs

def main():
    """Main function for language detection."""
    import argparse
    
    parser = argparse.ArgumentParser(description='Detect programming languages in a project')
    parser.add_argument('--project-root', default='.', help='Project root directory')
    parser.add_argument('--output', help='Output file for detection results')
    parser.add_argument('--format', choices=['json', 'yaml'], default='json', help='Output format')
    
    args = parser.parse_args()
    
    detector = LanguageDetector(args.project_root)
    config = detector.generate_scan_config()
    
    if args.output:
        output_path = Path(args.output)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        if args.format == 'json':
            with open(output_path, 'w') as f:
                json.dump(config, f, indent=2)
        else:
            with open(output_path, 'w') as f:
                yaml.dump(config, f, default_flow_style=False)
        
        print(f"📄 Detection results saved to {output_path}")
    else:
        if args.format == 'json':
            print(json.dumps(config, indent=2))
        else:
            print(yaml.dump(config, default_flow_style=False))

if __name__ == "__main__":
    main()
